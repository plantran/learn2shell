module Games
  # Contains all the methods and logic for the admin game part.
  class AdminGame
    require_relative '../helpers/custom_admin_system'

    def initialize
      @cs = Helpers::CustomAdminSystem.new
      @admin_path = "#{__dir__}/../#{ENV['ADMIN_PATH']}/admin"
      @root_path = "#{__dir__}/../#{ENV['ROOT_PATH']}"
      set_sonneries
    end

    # Starts the admin game
    def play
      return unless check_admin_password

      setup_dirs_and_files
      display_welcome_screen
      start_prompt
    end

    private

    # Prevents user from starting admin game without the password
    def check_admin_password
      print("#{'Entrez le mot de passe pour la session admin'.underline}: ")
      user_input = $stdin.gets.chomp
      if user_input == ENV['ADMIN_PASSWORD']
        true
      else
        puts 'Mauvais mot de passe.'
        false
      end
    end

    # Creates admin directories and files
    def setup_dirs_and_files
      system("mkdir -p #{@admin_path}")
      system("cp #{__dir__}/../docs/liste_mails.txt #{@admin_path}/liste_mails.txt")
      write_sonneries
      Dir.chdir(@admin_path)
    end

    # Initialize the sonneries file with instances values
    def write_sonneries
      File.open("#{@admin_path}/set_sonneries.txt", 'w') do |f| 
        txt = <<~TXT
          sonnerie pause = #{@sonneries[:break]}
          alarme incendie = #{@sonneries[:fire]}
          son sonnerie = #{@sonneries[:sound]}
        TXT
        f.puts(txt)
      end
    end

    # Set default values for the sonneries
    def set_sonneries
      @sonneries = { break: 55, fire: 1, sound: 'sonnerie normale' }
    end

    # Outputs the admin game welcome screen
    def display_welcome_screen
      puts <<~TXT
        Bienvenue dans le mode admin. Pour pouvez quitter à tout moment en tapant la commande exit.
        Tapez "aide" pour voir ce que vous pouvez faire.
      TXT
    end

    def start_prompt
      loop do
        user_input = @cs.prompt_and_user_input_with_path
        next if user_input.empty?

        cmd = user_input.split(' ').first.downcase
        args = user_input.split(' ')[1..]
        next if cmd_status?(cmd)
        return finish_admin_game if cmd == 'exit'

        @cs.execute_custom_command(cmd, *args)
      end
    end

    # Ends admin game, deletes folders and files, and change directory to root game
    def finish_admin_game
      Dir.chdir(@root_path)
      system("rm -rf #{@admin_path}")
      puts 'Fermeture du mode admin.'
    end

    # Handles the custom status command (displays status of "sonneries")
    def cmd_status?(cmd)
      update_sonneries
      return false unless cmd == 'status'

      puts <<~TXT
        La sonnerie de cours sonnera toutes les #{@sonneries[:break].bold.pink} minutes.
        L'alarme incendie sonnera #{@sonneries[:fire].bold.pink} fois par mois.
        La musique de la sonnerie de cours est #{@sonneries[:sound].bold.pink}.
      TXT
      true
    end

    # Update instance variable @sonneries based on values found inside the sonneries file.
    def update_sonneries
      File.readlines("#{@admin_path}/set_sonneries.txt").each do |line|
        identifier, value = line.chomp.split('=').map(&:strip)
        case identifier
        when 'sonnerie pause'
          @sonneries[:break] = value
        when 'alarme incendie'
          @sonneries[:fire] = value
        when 'son sonnerie'
          @sonneries[:sound] = value
        end
      end
    end
  end
end
