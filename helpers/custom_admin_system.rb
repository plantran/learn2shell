module Helpers
  # Custom commands for the admin game.
  class CustomAdminSystem < CustomSystem
    AUTHORIZED_COMMANDS = %w[ls edit mail chmod cp touch mkdir rm cat aide pwd cd echo].freeze

    def prompt_and_user_input_with_path
      dirname = Dir.getwd.sub(__dir__.sub('helpers', ''), '')
      print("#{'Dossier actuel:'.green.bold.underline} #{dirname.red.bold} #{' -> '.green.bold}")
      $stdin.gets.chomp&.strip
    end

    private

    # Calls custom `aide` command, which displays the admin help manual.
    def my_aide(_args)
      system("less #{__dir__}/../docs/aide_admin")
    end

    # Custom mail
    def my_mail(args)
      return if no_mail_argument?(args)

      system("mail #{args.join(' ')}")
    end

    def command_is_authorized?(cmd)
      AUTHORIZED_COMMANDS.include?(cmd.downcase)
    end

    def no_mail_argument?(args)
      return false unless args.size != 1

      puts("Tu dois indiquer #{'une'.underline} adresse mail après la commande !".red)
      true
    end

    # Prevents the user from accessing the parent directories when in the root directory if the game.
    def trying_to_access_parent_unauthorized(current_dir_name, path)
      unless accessing_parent_of_admin(current_dir_name, path) ||
             accessing_absolute_path(path) ||
             accessing_outside_parent(path)
        return false
      end

      puts <<~TXT.red
        Attention, tu ne peux pas aller plus loin, il faut que tu restes dans le dossier admin \
        et les dossiers qu'il y a dedans ! Tu peux taper `exit` pour quitter le mode admin.
      TXT
      true
    end

    # Returns false if cd path is parent to admin game root folder.
    def accessing_parent_of_admin(current_dir_name, path)
      return true if current_dir_name == 'admin' && path == '..'

      false
    end

    # Prevents user from accessing relative paths outside of admin game root folder.
    def accessing_outside_parent(path)
      base_path = Pathname.new("#{__dir__}/../ECOLE/ADMIN/admin")
      pn = Pathname.new(path)
      return false if base_path.expand_path == pn.expand_path
      return false if pn.expand_path.to_s.start_with?(base_path.expand_path.to_s)

      true
    end
  end
end
