# Provides custom methods for system calls
module Helpers
  # Custom commands for the free game
  class CustomSystem
    require 'pathname'

    AUTHORIZED_COMMANDS = %w[ls edit chmod cp touch mkdir rm cat aide ecole pwd cd echo].freeze
    MANDATORY_DIRS = %w[ADMIN ELEVES SECURITE VIE_SCOLAIRE MOTS_DE_PASSE UTILISATEURS admin set_sonneries.txt].freeze

    # Displays fake prompt and gets user input.
    def prompt_and_user_input(downcased: true)
      print('-> '.bold.green)
      inp = $stdin.gets.chomp&.strip
      downcased ? inp.downcase : inp
    end

    def prompt_and_user_input_with_path(downcased: true)
      dirname = Dir.getwd.sub(__dir__.sub('helpers', ''), '')
      print("#{'Dossier actuel:'.green.bold.underline} #{dirname.red.bold} #{' -> '.green.bold}")
      inp = $stdin.gets.chomp&.strip
      downcased ? inp.downcase : inp
    end

    # Makes sure that the command is valid, format arguments and send to the appropriate function.
    def execute_custom_command(cmd, *args)
      return output_error(cmd) unless command_is_authorized?(cmd)

      args = %w[cd edit].include?(cmd) ? args : protected_args(args)
      send("my_#{cmd}", args)
    end

    private

    # Ensure that arguements are surrounded by single quotes.
    def protected_args(args)
      args.map { |a| "'#{a}'" }
    end

    # Custom ls
    def my_ls(args)
      system("ls -G #{args.join(' ')}")
    end

    # Custom cd
    def my_cd(args)
      path = args[0]
      current_dir_name = File.basename(Dir.getwd)
      return if trying_to_access_parent_unauthorized(current_dir_name, path)
      return if directory_does_not_exist(path)
      return unless handle_user_directories(current_dir_name, path)

      Dir.chdir(path)
    end

    # Calls custom `edit` function, opens text editor.
    def my_edit(args)
      path = args[0]
      return if editing_forbidden_files(path)

      system("#{ENV['EDITOR_PATH']} #{path}")
    end

    # Custom chmod
    def my_chmod(args)
      return if chmod_unauthorized_error(args)

      system("chmod #{args.join(' ')}")
    end

    # Custom cp
    def my_cp(args)
      system("cp #{args.join(' ')}")
    end

    # Custom touch
    def my_touch(args)
      system("touch #{args.join(' ')}")
    end

    # Custom mkdir
    def my_mkdir(args)
      system("mkdir -p #{args.join(' ')}")
    end

    # Custom rm
    def my_rm(args)
      return if rm_unauthorized_error(args)

      system("rm #{args.join(' ')}")
    end

    # Custom cat
    def my_cat(args)
      system("cat #{args.join(' ')}")
    end

    # Calls custom `aide` command, which displays the help manual.
    def my_aide(_args)
      system("less #{__dir__}/../docs/aide")
    end

    # Calls custom `ecole` command, which change the directory to the root path of the game.
    def my_ecole(_args)
      Dir.chdir("#{__dir__}/../ECOLE")
    end

    # Custom pwd
    def my_pwd(_args)
      puts Dir.getwd.sub(__dir__.sub('helpers', ''), '')
    end

    # Custom echo
    def my_echo(args)
      # If echo > nouveau_mdp.txt
      return if handle_change_teacher_pw(args)

      system("echo #{args.join(' ')}")
    end

    # Displays a custom error when the command is not found.
    def output_error(cmd)
      puts "La commande '#{cmd}' n'existe pas ou a été mal formulée.".red
    end

    # Prevents the deletion of mandatory directories and outputs an error message.
    def rm_unauthorized_error(args)
      return false unless MANDATORY_DIRS.any? do |md|
        args.include?("'#{md}'")
      end

      puts "Tu n'as pas l'autorisation de supprimer ce dossier.".red
      true
    end

    # Prevents permissions change of mandatory directories and outputs an error message.
    def chmod_unauthorized_error(args)
      return false unless MANDATORY_DIRS.any? do |md|
        args.include?("'#{md}'")
      end

      puts "Tu n'as pas l'autorisation de modifier les droits de ce dossier.".red
      true
    end

    # Checks whether the command user entered is authorized or not
    def command_is_authorized?(cmd)
      AUTHORIZED_COMMANDS.include?(cmd.downcase)
    end

    # Prevents the user from accessing the parent directories when in the root directory if the game.
    def trying_to_access_parent_unauthorized(current_dir_name, path)
      unless accessing_parent_of_ecole(current_dir_name, path) ||
             accessing_absolute_path(path) ||
             accessing_outside_parent(path)
        return false
      end

      puts <<~TXT.red
        Attention, tu ne peux pas aller plus loin, il faut que tu restes dans le dossier ECOLE \
        et les dossiers qu'il y a dedans !"
      TXT
      true
    end

    # Returns false if cd path is parent to game root folder.
    def accessing_parent_of_ecole(current_dir_name, path)
      return true if current_dir_name == 'ECOLE' && path == '..'

      false
    end

    # Prevents user from accessing absolute paths directories.
    def accessing_absolute_path(path)
      return true if path.start_with?('/')

      false
    end

    # Prevents user from accessing relative paths outside of game root folder.
    def accessing_outside_parent(path)
      base_path = Pathname.new("#{__dir__}/../ECOLE")
      pn = Pathname.new(path)
      return false if base_path.expand_path == pn.expand_path
      return false if pn.expand_path.to_s.start_with?(base_path.expand_path.to_s)

      true
    end

    # Checks if the given path exists and is a directory, outputs an error message if not.
    def directory_does_not_exist(path)
      return false if Dir.exist?(path)

      puts "Attention, ce dossier n'existe pas. Ou peut-être que tu essaies d'accéder à un fichier ?".red
      true
    end

    # Protect the directories inside `UTILISATEURS` to be accessed without the password.
    def handle_user_directories(current_dir_name, path)
      return true unless current_dir_name == 'UTILISATEURS'
      return true if path.start_with?('.')

      admin_password = fetch_admin_password(path)
      print("#{'Entrez le mot de passe pour entrer dans le dossier'.underline}: ")
      user_input = $stdin.gets.chomp&.strip
      if user_input == admin_password
        puts "Bienvenue #{path.split('_').first}"
        true
      else
        puts 'ERREUR: Mauvais mot de passe !'.red
        false
      end
    end

    # Fetches password from the corresponding admin directory.
    def fetch_admin_password(path)
      f = File.open("#{__dir__}/../ECOLE/SECURITE/MOTS_DE_PASSE/.#{path}.txt", 'r')
      f.gets.chomp
    rescue Errno::ENOENT
      nil
    end

    # Checks if the user is trying to edit "forbidden files".
    def editing_forbidden_files(path)
      if ['.passwd', 'nouveau_mdp.txt'].include?(path) || File.basename(Dir.getwd) == 'MOTS_DE_PASSE'
        puts "Tu n'as pas le droit d'éditer des fichiers mots de passe.".red
        return true
      end

      false
    end

    # Checks if the user is changing a teacher's password
    def handle_change_teacher_pw(args)
      return false unless args[1] == "'>'" && args[2] == "'nouveau_mdp.txt'"

      parent_dir = File.expand_path('..', Dir.pwd).split('/').last
      return false unless parent_dir == 'UTILISATEURS'

      echo_and_update_password(args)
    end

    # Writes new teacher's password in file
    def echo_and_update_password(args)
      new_pass = args[0].gsub("'", '')
      current_dir_name = Dir.pwd.split('/').last
      File.open('nouveau_mdp.txt', 'w') { |f| f.puts(new_pass) }
      update_new_teacher_password(current_dir_name, new_pass)
    end

    # Updates teachers's password
    def update_new_teacher_password(current_dir_name, new_pass)
      File.open("../../MOTS_DE_PASSE/.#{current_dir_name}.txt", 'w') do |f|
        f.puts(new_pass)
      end
      puts 'Le mot de passe a été changé !'
      true
    rescue Errno::ENOENT
      false
    end
  end
end
