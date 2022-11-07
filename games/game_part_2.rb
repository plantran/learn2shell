module Games
  class GamePart2
    include CustomSystem

    def initialize(name)
      @name = name
      @name_slugged = @name.split(' ').map(&:downcase).join('_')
      @ascii_autorized = Asciiartor.new(:computer_authorized)
      ls_game
      cd_game
      cd_own_dir_game
      change_notes_game
      finish
    end

    private

    def ls_game
      output_ls_game_texts
      loop do
        user_input = prompt_and_user_input
        if user_input == 'ls'
          system('ls -G')
          return
        else
          puts "Tu dois entrer une commande qui permet de regarder tous les fichiers et dossiers qui sont à l'intérieur du dossier dans lequel tu es !"
        end
      end
    end

    def cd_game
      output_cd_game_texts
      loop do
        user_input = prompt_and_user_input
        if user_input == 'cd eleves'
          Dir.chdir('ELEVES')
          return
        else
          puts "Tu dois aller dans le dossier #{'ELEVES'.underline} avec la commande #{'cd'.underline} !"
        end
      end
    end

    def cd_own_dir_game
      output_cd_own_dir_game_texts
      loop do
        case prompt_and_user_input
        when "cd #{@name_slugged}"
          Dir.chdir(@name_slugged)
          return
        when 'ls'
          system('ls -G')
        else
          puts "Tu dois aller dans ton dossier en écrivant exactement ton nom (regarde où est ton dossier avec la commande #{'ls'.underline} !"
        end
      end
    end

    def change_notes_game
      output_change_notes_game_texts
      loop do
        case prompt_and_user_input
        when 'edit bulletin.txt'
          system("#{ENV['EDITOR_PATH']} bulletin.txt")
        when 'ls'
          system('ls -G')
        when 'finish'
          return
        else
          puts "Tu peux changer tes notes en éditant le fichier ! Quand tu as fini, tapes la commande #{'finish'.underline} !"
        end
      end
    end

    def finish
      output_finish_texts
      loop do
        user_input = prompt_and_user_input
        return if user_input == 'ecole'

        puts "Tu dois entrer la commande #{'ecole'.underline} !"
      end
    end

    def output_cd_game_texts
      txt = <<~TXT.bold.blue
        >> SUPER, COMME TU PEUX LE VOIR, IL Y A UN DOSSIER "ELEVES", UN DOSSIER "SECURITE", UN DOSSIER "ADMIN" ET UN DOSSIER "VIE_SCOLAIRE"
        ET SI ON COMMENÇAIT PAR CHANGER TES NOTES, CE SERAIT SYMPAS D'AVOIR DES 20/20 PARTOUT ! \
        COMMENCE PAR ALLER DANS LE DOSSIER #{'ELEVES'.underline} ! <<
      TXT
      txt += <<~TXT.yellow.italic
        -> Pour se déplacer dans un dossier, utilise la commande #{'cd'.underline}, suivie d'un espace et du nom du dossier \
        où tu veux te déplacer !
      TXT
      puts txt
    end

    def output_ls_game_texts
      @ascii_autorized.display
      txt = <<~TXT.bold.blue
        \t>> BRAVO, TU AS RÉUSSI À T'INFILTRER DANS LE SYSTÈME INFORMATIQUE DE TON ÉCOLE !\n\tCOMMENÇONS PAR VOIR CE QU'IL Y A À L'INTÉRIEUR !<<
      TXT
      txt += <<~TXT.yellow.italic
        \t-> Pour voir tous les fichiers et dossiers qu'il y a dans le répertoire où tu es, tape la commande #{'ls'.underline}
      TXT
      puts txt
    end

    def output_cd_own_dir_game_texts
      @ascii_autorized.display
      txt = <<~TXT.bold.blue
        \t>> REGARDE TOUS LES ÉLÈVES QU'IL Y A ! CHERCHE TON DOSSIER AVEC TON NOM ET VA DEDANS ! <<
      TXT
      txt += <<~TXT.yellow.italic
        \t-> Pour voir tous les dossiers qu'il y a utilise la commande #{'ls'.underline} et pour accéder à ce dossier, \
        utilise la commande #{'cd'.underline} !

      TXT
      puts txt
    end

    def output_change_notes_game_texts
      @ascii_autorized.display
      txt = <<~TXT.bold.blue
        \t>> TRES BIEN, MAINTENANT QUE TU ES DANS TON DOSSIER, REGARDE TOUS LES FICHIERS QU'IL Y A. \
        CE SONT TOUTES LES MATIERES QUE TU AS, DEDANS, IL Y A TA NOTE. A TOI DE JOUER POUR MODIFIER CES \
        NOTES ET METTRE CELLES QUE TU VEUX ! <<
      TXT
      txt += <<~TXT.yellow.italic
        \t-> Pour voir tous les fichiers qu'il y a dans le dossier où tu es, tape la commande #{'ls'.underline}.
        \tPour modifier un fichier, tape la commande #{'edit'.underline} , un espace et le nom du fichier que tu veux modifier !
        \tQuand tu as terminé, entre la commande  #{'finish'.underline} !
      TXT
      puts txt
    end

    def output_finish_texts
      txt = <<~TXT.bold.blue
        \t>> GENIAL, J'ESPERE QUE TU T'ES MIS PLEIN DE BONNES NOTES ! IL EST MAINTENANT TEMPS DE PASSER AUX CHOSES SÉRIEUSES! <<
      TXT
      txt += <<~TXT.yellow.italic
        \tTape la commande #{'ecole'.underline} quand tu es prêt à continuer.
      TXT
      puts txt
    end
  end
end
