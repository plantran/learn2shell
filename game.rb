class Game
  require_relative 'outputer'
  require_relative 'custom_system'
  require_relative 'asciiartor'
  require_relative 'students'
  Dir["#{__dir__}/games/*.rb"].each { |file| require file }

  include CustomSystem

  def initialize
    @ascii_denied = Asciiartor.new(:computer_denied)
    welcome_new_user
    Games::GameIntro.new(@name)
    Students.new.init_for_one(@name)
    Games::GamePart2.new(@name)
  end

  private

  def welcome_new_user
    @ascii_denied.display
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
      @name = prompt_and_user_input(downcased: false)
      break unless @name.empty? || @name.split.size != 2

      puts "Tu dois rentrer tom prénom #{'ET'.underline} ton nom de famille."
    end
  end
end