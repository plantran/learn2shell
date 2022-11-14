module Games
  class FreeGame
    def initialize(custom_system)
      @cs = custom_system
      @admin_game = AdminGame.new
      display_welcome_screen
      start_prompt
    end

    private

    def start_prompt
      loop do
        user_input = @cs.prompt_and_user_input_with_path(downcased: false)
        next if user_input.empty?

        cmd = user_input.split(' ').first.downcase
        args = user_input.split(' ')[1..]
        which_command(cmd, args)
      end
    end

    def which_command(cmd, args)
      if cmd == 'admin'
        @admin_game.play
      else
        @cs.execute_custom_command(cmd, *args)
      end
    end

    def display_welcome_screen
      Asciiartor.access_authorized
      puts "\n\t>> VOILA, MAINTENTANT TU AS LES BASES, À TOI DE JOUER ! <<\n".bold.blue
      puts <<~TXT.yellow.italic
        \t-> Tape la commande "aide" pour voir la liste de toutes les commandes et voir tout ce que tu peux faire !
      TXT
    end
  end
end
