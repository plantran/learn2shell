# Class and methods for the first part of the game (introduction).
module Games
  class GameIntro
    include CustomSystem

    def initialize(name)
      @name = name
      @ascii_denied = Asciiartor.new(:computer_denied)
      welcome_screen
      first_part
      second_part
      last_part
    end

    private

    def welcome_screen
      @ascii_denied.display
      puts "\t... Hmm, je ne connais pas ce nom ..."
      sleep(2)
      puts "\t... Je vais vérifier si votre ordinateur est bien enregistré dans notre base de données..."
      sleep(2)
    end

    def first_part
      txt = <<~TXT.blue
        >> VITE ! ENREGISTRE TON ORDINATEUR POUR QUE LE SYSTEME NE DETECTE PAS QUE TU ES UN ÉLÈVE ! \
        POUR CELA, TU DOIS CREER UN FICHIER QUI S'APPELLE #{'mon_ordinateur'.bold} <<\n
      TXT
      txt += <<~TXT.yellow.italic
        -> Pour créer un fichier, utilise la commande #{'touch'.underline}, un espace et le nom du fichier que tu veux créer.
        -> Par exemple: #{'touch'.underline} mon_ordinateur
      TXT
      puts txt
      first_part_create_file_exo
    end

    def first_part_create_file_exo
      loop do
        user_input = prompt_and_user_input
        if user_input == 'touch mon_ordinateur'
          # TODO: System class
          system 'touch mon_ordinateur'
          return
        else
          puts "Tu dois créer un fichier nommé #{'mon_ordinateur'.underline} avec la commande touch !\n"
        end
      end
    end

    def second_part
      @ascii_denied.display
      txt = ">> IL FAUT MAINTENANT AJOUTER TON ADRESSE IP DANS CE FICHIER ! <<\n".blue.bold
      txt += <<~TXT.blue.italic
        💡   -> Une adresse IP est l'adresse virtuelle de ton ordinateur. Elle est unique et chaque ordinateur en possède une différente !
      TXT
      txt += <<~TXT.yellow.italic
        -> Pour ajouter ton adresse IP dans le fichier, tape la commande #{'my_ip > mon_ordinateur'.underline}, cela récupèrera ton \
        adresse IP et la copiera directement dans le fichier grâce au caractère `>`!
      TXT
      puts txt
      first_part_edit_file_exo
    end

    def first_part_edit_file_exo
      loop do
        user_input = prompt_and_user_input
        # TODO: Add random ip in file
        return if user_input == 'my_ip > mon_ordinateur'

        puts "Tu dois ajouter ton adresse IP avec la commande #{'my_ip > mon_ordinateur'.underline} puis appuyer sur la touche ENTRÉE.\n"
      end
    end

    def last_part
      @ascii_denied.display
      2.times do
        puts ' ...'
        sleep(1)
      end
      Asciiartor.new(:access_authorized_welcome).display(with_clear: false)
      puts <<~TXT
        Bonjour #{@name} et bienvenue dans le système de informatique de l'école.\n Appuie sur #{'ENTRÉE'.underline} pour continuer !
      TXT
      loop { return if $stdin.gets == "\n" }
    end
  end
end
