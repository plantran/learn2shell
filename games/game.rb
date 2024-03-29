module Games
  class Game
    require_relative '../helpers/outputer'
    require_relative '../helpers/custom_system'
    require_relative '../helpers/asciiartor'
    require_relative '../helpers/students'
    Dir["#{__dir__}/*.rb"].each { |file| require file }

    include Asciiartor

    def initialize
      @cs = Helpers::CustomSystem.new
      welcome_new_user
      Games::GameIntro.new(@name, @cs)
      Students.new.init_for_one(@name)
      Games::GamePart2.new(@name, @cs)
      Games::FreeGame.new(@cs)
    end

    private

    def welcome_new_user
      Asciiartor.access_denied
      txt = <<~TXT
          \tBonjour, je suis le système de surveillance de l'école.
                  Pouvez-vous vous identifier ?

          \t>> Écris ton prénom et ton nom de famille séparés par un espace. Quand tu as fini, appuie sur la touche \
        #{'ENTRÉE'.bold.blue.underline}.
      TXT
      puts txt
      fetch_name
    end

    def fetch_name
      loop do
        @name = @cs.prompt_and_user_input(downcased: false)
        break unless @name.empty? || @name.split.size != 2

        puts "Tu dois rentrer tom prénom #{'ET'.underline} ton nom de famille."
      end
    end
  end
end
