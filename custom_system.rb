# Provides custom methods for system calls
module CustomSystem
  require 'pathname'

  AUTHORIZED_COMMANDS = %w[ls edit mail chmod cp touch mkdir rm cat aide ecole pwd cd].freeze
  MANDATORY_DIRS = %w[ADMIN ELEVES SECURITE VIE_SCOLAIRE MOTS_DE_PASSE UTILISATEURS].freeze

  def prompt_and_user_input(downcased: true)
    print('-> '.bold.green)
    inp = $stdin.gets.chomp&.strip
    downcased ? inp.downcase : inp
  end

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

  def my_ls(args)
    system("ls -G #{args.join(' ')}")
  end

  def my_cd(args)
    # TODO: Handle absolute and relative paths.
    path = args[0]
    current_dir_name = File.basename(Dir.getwd)
    return if trying_to_access_parent_unauthorized(current_dir_name, path)
    return if directory_does_not_exist(path)
    return unless handle_user_directories(current_dir_name, path)

    Dir.chdir(path)
  end

  def my_edit(args)
  end

  def my_mail(args)
    system("mail #{args.join(' ')}")
  end

  def my_chmod(args)
    return if chmod_unauthorized_error(args)

    system("chmod #{args.join(' ')}")
  end

  def my_cp(args)
    system("cp #{args.join(' ')}")
  end

  def my_touch(args)
    system("touch #{args.join(' ')}")
  end

  def my_mkdir(args)
    system("mkdir -p #{args.join(' ')}")
  end

  def my_rm(args)
    return if rm_unauthorized_error(args)

    system("rm #{args.join(' ')}")
  end

  def my_cat(args)
    system("cat #{args.join(' ')}")
  end

  def my_aide(_args)
    system("less #{__dir__}/aide")
  end

  def my_ecole(_args)
    Dir.chdir("#{__dir__}/ECOLE")
  end

  def my_pwd(_args)
    puts Dir.getwd.sub(__dir__, '')
  end

  def output_error(cmd)
    puts "La commande '#{cmd}' n'existe pas ou a été mal formulée.".red
  end

  def rm_unauthorized_error(args)
    return false unless MANDATORY_DIRS.any? do |md|
      args.include?("'#{md}'")
    end

    puts "Tu n'as pas l'autorisation de supprimer ce dossier.".red
    true
  end

  def chmod_unauthorized_error(args)
    return false unless MANDATORY_DIRS.any? do |md|
      args.include?("'#{md}'")
    end

    puts "Tu n'as pas l'autorisation de modifier les droits de ce dossier.".red
    true
  end

  def trying_to_access_parent_unauthorized(current_dir_name, path)
    return false unless current_dir_name == 'ECOLE' && path == '..'

    puts <<~TXT.red
      Attention, tu ne peux pas aller plus loin, il faut que tu restes dans le dossier ECOLE \
      et les dossiers qu'il y a dedans !"
    TXT
    true
  end

  def directory_does_not_exist(path)
    return false if Dir.exist?(path)

    puts "Attention, ce dossier n'existe pas. Ou peut-être que tu essaies d'accéder à un fichier ?".red
    true
  end

  def handle_user_directories(current_dir_name, path)
    return true unless current_dir_name == 'UTILISATEURS'
    return true if path == '..'

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

  def fetch_admin_password(path)
    f = File.open("#{__dir__}/ECOLE/SECURITE/MOTS_DE_PASSE/.#{path}.txt", 'r')
    f.gets
  rescue Errno::ENOENT
    nil
  end
end
