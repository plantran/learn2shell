class Game
  require_relative 'outputer'
  require_relative 'asciiartor'
  # TODO: Require multiple and add inside folder
  require_relative 'game_intro'

  def initialize
    @ascii_denied = Asciiartor.new(:computer_denied)
    @ascii_autorized = Asciiartor.new(:computer_authorized)
    @ascii_autorized_welcome = Asciiartor.new(:access_authorized_welcome)
    welcome_new_user
    GameIntro.new(@name)
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
      print '-> '.bold.green
      @name = $stdin.gets.chomp&.strip
      break unless @name.empty? || @name.split.size != 2

      puts "Tu dois rentrer tom prénom #{'ET'.underline} ton nom de famille."
    end
  end
end
