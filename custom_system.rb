# Provides custom methods for system calls
module CustomSystem
  require 'pathname'

  AUTHORIZED_COMMANDS = %w[ls edit mail chmod cp touch mkdir rm cat aide ecole pwd cd].freeze
  MANDATORY_DIRS = %w[ADMIN ELEVES SECURITE VIE_SCOLAIRE MOTS_DE_PASSE UTILISATEURS].freeze

  # Displays fake prompt and gets user input.
  def prompt_and_user_input(downcased: true)
    print('-> '.bold.green)
    inp = $stdin.gets.chomp&.strip
    downcased ? inp.downcase : inp
  end

  # Makes sure that the command is valid, format arguments and send to the appropriate function.
  def execute_custom_command(cmd, *args)
    return output_error(cmd) unless AUTHORIZED_COMMANDS.include?(cmd.downcase)

    args = cmd == 'cd' ? args : protected_args(args)
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
  def my_edit(args); end

  # Custom mail
  def my_mail(args)
    system("mail #{args.join(' ')}")
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
    system("less #{__dir__}/docs/aide")
  end

  # Calls custom `ecole` command, which change the directory to the root path of the game.
  def my_ecole(_args)
    Dir.chdir("#{__dir__}/ECOLE")
  end

  # Custom pwd
  def my_pwd(_args)
    puts Dir.getwd.sub(__dir__, '')
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

  def accessing_parent_of_ecole(current_dir_name, path)
    return true if current_dir_name == 'ECOLE' && path == '..'

    false
  end

  def accessing_absolute_path(path)
    return true if path.start_with?('/')

    false
  end

  def accessing_outside_parent(path)
    base_path = Pathname.new("#{__dir__}/ECOLE")
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
    # TODO: Use admin class to fetch and update password.
    f = File.open("#{__dir__}/ECOLE/SECURITE/MOTS_DE_PASSE/.#{path}.txt", 'r')
    f.gets
  rescue Errno::ENOENT
    nil
  end
end
