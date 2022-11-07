module Games
  class FreeGame
    include CustomSystem

    def initialize
      @ascii_autorized = Asciiartor.new(:computer_authorized)
      display_welcome_screen
      start_prompt
    end

    private

    def start_prompt
      loop do
        user_input = prompt_and_user_input(downcased: false)
        next if user_input.empty?

        cmd = user_input.split(' ').first.downcase
        args = user_input.split(' ')[1..]
        execute_custom_command(cmd, *args)
      end
    end

    def display_welcome_screen
      @ascii_autorized.display
      puts "\t>> VOILA, MAINTENTANT TU AS LES BASES, À TOI DE JOUER ! <<\n".bold.blue
      puts <<~TXT.yellow.italic
        \t-> Tape la commande "aide" pour voir la liste de toutes les commandes et voir tout ce que tu peux faire !
      TXT
    end
  end
end
