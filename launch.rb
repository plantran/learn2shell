#!/usr/bin/env ruby
# encoding: utf-8

$EDITOR_PATH = "/Applications/Sublime\\ Text.app/Contents/SharedSupport/bin/subl "

class String    # colorization

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red ; colorize(31)  end

  def green ; colorize(32) end

  def yellow ; colorize(33) end

  def blue ; colorize(34) end

  def pink ; colorize(35) end

  def light_blue ; colorize(36) end

def bold;           "\e[1m#{self}\e[22m" end
def italic;         "\e[3m#{self}\e[23m" end
def underline;      "\e[4m#{self}\e[24m" end
def blink;          "\e[5m#{self}\e[25m" end
end

# ------------------------------------------------------------------------ #

def ascii_art(a)
system "clear"

if a == 0
puts "            ____________________________________________________  					"
puts "           /                                                    \\						"
puts "          |    _____________________________________________     |                   	"
puts "          |   |                                             |    | 					"
puts "          |   |  C:\\\> _ " + "ACCES REFUSÉ".bold.red + "                        |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |_____________________________________________|    |                   	"
puts "          |                                                      |                   	"
puts "           \\_____________________________________________________/                   	"
puts "                  \\\_______________________________________/                   		"
puts "               _______________________________________________                   		"
puts "            _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_                   	"
puts "         _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_                   "
puts "      _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_                   	"
puts "   _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_                   	"
puts "_-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.`-_                   	"
puts ":-----------------------------------------------------------------------------:                   	"
puts "`---._.-----------------------------------------------------------------._.---'                   	"
end
if a == 1

puts "            ____________________________________________________  					"
puts "           /                                                    \\						"
puts "          |    _____________________________________________     |                   	"
puts "          |   |                                             |    | 					"
puts "          |   |  C:\\\> _ " + "ACCES AUTORISÉ".bold.green + "                      |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |                                             |    |                   	"
puts "          |   |_____________________________________________|    |                   	"
puts "          |                                                      |                   	"
puts "           \\_____________________________________________________/                   	"
puts "                  \\\_______________________________________/                   		"
puts "               _______________________________________________                   		"
puts "            _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_                   	"
puts "         _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_                   "
puts "      _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_                   	"
puts "   _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_                   	"
puts "_-'.-.-.-.-.-. .---.-. .-----------------------------. .-.---. .---.-.-.-.`-_                   	"
puts ":-----------------------------------------------------------------------------:                   	"
puts "`---._.-----------------------------------------------------------------._.---'                   	"

end

end


def ascii_autorise()

puts "	           _____ _____ ______  _____           _    _ _______ ____  _____  _____  _____   __  ".green
puts "	    /\\   / ____/ ____|  ____|/ ____|     /\\  | |  | |__   __/ __ \\|  __ \\|_   _|/ ____|_/_/_ 	".green
puts "	   /  \\ | |   | |    | |__  | (___      /  \\ | |  | |  | | | |  | | |__) | | | | (___ | ____|	".green
puts "	  / /\\ \\| |   | |    |  __|  \\___ \\    / /\\ \\| |  | |  | | | |  | |  _  /  | |  \\___ \\|  _|  	".green
puts "	 / ____ \\ |___| |____| |____ ____) |  / ____ \\ |__| |  | | | |__| | | \\ \\ _| |_ ____) | |___ 	".green
puts "	/_/    \\_\\_____\\_____|______|_____/  /_/    \\_\\____/   |_|  \\____/|_|  \\_\\_____|_____/|_____|	".green

puts "\n"
end

def reset_sonnerie()

	File.open("admin/set_sonneries","w") do |f|
		f.write("sonnerie pause = 55\n")
		f.write("alarme incendie = 1\n")
		f.write("son sonnerie = sonnerie normale\n")
	end
end



def boucle_part2(commande)
	while (1)
		display_prompt()
		input = STDIN.gets.chomp.strip.downcase
		if (input == "ls")
			puts ""
			print "-> ".bold.red
			system "ls -G"
			return

		else
			puts "Tu dois entrer une commande qui permet de regarder tous les fichiers et dossiers qui sont à l'intérieur du dossier dans lequel tu es !"
		end
	end

end

def display_prompt() # AFFICHAGE DU PROMPT

trap "SIGINT" do
	puts "Appuies sur ENTREE pour pouvoir réutiliser le programme"
end
dirname = File.basename(Dir.getwd)
print "Répertoire actuel:".green.bold.underline + " " + dirname.red.bold + " -> ".green.bold
end


def debut_ordi()
	while (1)
		print "-> ".bold.green
		user = STDIN.gets.chomp
			if user == "touch mon_ordinateur"
				system "touch mon_ordinateur"
				return
			else
				puts "Tu dois créer un fichier nommé " + "mon_ordinateur".underline + " avec la commande touch !\n"
			end

	end
end


# ---------------- FONCTION DU DEBUT POUR EDITER LE FICHIER -------------------------- #

def debut_edit()
	while (1)
	file = File.new("mon_ordinateur", "r")
		if file.gets == "OK"
			return
		end
	print "-> ".bold.green
	user = STDIN.gets.chomp
		if user == "edit mon_ordinateur"
			system $EDITOR_PATH + "mon_ordinateur"
			file = File.new("mon_ordinateur", "r")
			if file.gets == "OK"
				return
			end
		else
			puts "Tu dois éditer le fichier " + "mon_ordinateur".underline + " avec la commande  edit et écrire" + " OK ".underline + "à l'intérieur puis appuyer sur ENTREE !\n"
		end
	end
end


# ------------------ FONCTION PREMIERE PARTIE CONNECTION A L'ECOLE ------------------------
def debut()
trap "SIGINT" do
	puts "Appuies sur ENTREE pour pouvoir réutiliser le programme"
end
ascii_art(0)
puts "	Bonjour, je suis le système de surveillance de l'école.\n\tPouvez-vous vous identifier ?"
puts ""
puts ">> RENTRE ICI TON PRENOM ET TON NOM DE FAMILLE. QUAND TU AS FINI APPUIE SUR LA TOUCHE ".bold.blue + "ENTREE".bold.blue.underline + " <<\n".bold.blue
while (1)
	print "-> ".bold.green
	nom_user = STDIN.gets.chomp
	if (nom_user == "" || nom_user.split.size < 2 || nom_user.split.size > 2)
		puts "Tu dois rentrer tom prénom et ton nom de famille"
	else
		break
	end
end
nom_user = nom_user.strip
ascii_art(0)
puts "	... Hmm, je ne connais pas ce nom ..."
sleep(4)
puts "	... Je vais vérifier si votre ordinateur est bien enregistré dans notre base de données..."
sleep(4)
puts "\n\n"

puts ">> VITE ! ENREGISTRE TON ORDINATEUR POUR QUE LE SYSTEME NE DETECTE PAS QUE TU ES UN ELEVE !".bold.blue
puts "	POUR CELA, TU DOIS CREER UN FICHIER QUI S'APPELLE ".bold.blue + "mon_ordinateur".bold.blue.underline + " <<".bold.blue
puts ""
puts "-> Pour créer un fichier, utilise la commande ".italic.yellow + "touch".italic.yellow.underline + " , un espace et le nom du fichier que tu veux créer ".italic.yellow + " !\n".italic.yellow
debut_ordi()
ascii_art(0)
puts "\n>> IL FAUT MAINTENANT METTRE LE MOT OK DANS CE FICHIER ! <<\n".bold.blue
puts "-> Pour éditer un fichier, tape la commande ".italic.yellow + "edit".italic.yellow.underline + " , un espace et le nom du fichier que tu veux éditer ".yellow.italic + " !".italic.yellow
puts "	 Ensuite, appuie sur ENTRÉE\n".italic.yellow
debut_edit()
ascii_art(0)
puts "\n	..."
sleep (2)
puts "	..."
sleep(2)
ascii_art(1)
ascii_autorise()
sleep(3)
ascii_art(1)
puts "	Bonjour " + nom_user + " et bienvenue dans le système informatique de l'école.\n"
puts "	Appuie sur " + "ENTRÉE".underline + " pour continuer !"
while (1)
	if STDIN.gets == "\n"
		return nom_user
	end
end
return nom_user
end

# ----------------------------- FONCTION DEUXIEME PARTIE : CHANGER LES NOTES ------------------------

def part2_cd_eleves()
	while (1)
		display_prompt()
		input = STDIN.gets.chomp
		if input != ""
			file = input.split(' ')[1..-1].join(' ')
		end
		if input.partition(" ").first == "cd" and  file != file.downcase and File.exist?(file) == true and file == "ELEVES"
			Dir.chdir input.split(' ')[1..-1].join(' ')
			return
		end
		if File.basename(Dir.getwd) == "ELEVES"
			return
		else
			puts "Tu dois aller dans le dossier " + "ELEVES".underline + " avec la commande " + "cd".underline + " !\n"
		end
	end
end

# --------------------------- FONCTION DEUXIEME PARTIE : CHANGER LES NOTES ------------------------------

def part2_notes(name)
	while (1)
		display_prompt()
		input = STDIN.gets.chomp
		if input != ""
			file = input.split(' ')[1..-1].join(' ')
		end
		if input == "ls"
			system "ls -G"
		elsif input and input.partition(" ").first == "edit" and  file != file.downcase and File.exist?(file) == true and File.directory?(file) == false
			system $EDITOR_PATH + "\"" + file + "\""
		elsif input == "finish"
			return ;
		else
			puts "Tu peux changer tes notes en éditant le fichier ! Quand tu as fini, tapes la commande " + "finish".underline + " !"
		end
		system "../../../bulletin.rb " + "./" + " " + name
	end
end

def part2_namedir(name)
	while (1)
		display_prompt()
		input = STDIN.gets.chomp
		if input != ""
			file = input.split(' ')[1..-1].join(' ')
		end
		if input.partition(" ").first == "cd" and file == name
			Dir.chdir name
			return
		elsif input == "ls"
			system "ls -G"
		else
			puts "Tu dois aller dans ton dossier en écrivant exactement ton nom (regarde où est ton dossier avec la commande " + "ls".underline + ") !"
		end
	end
end

def part2_last()
	while (1)
		display_prompt()
		input = STDIN.gets.chomp
		if input != ""
			file = input.split(' ')[1..-1].join(' ')
		end
		if input.partition(" ").first == "cd" and file == "BULLETIN"
			Dir.chdir "BULLETIN"
		elsif input == "ls"
			system "ls -G"
		elsif input.partition(" ").first == "edit" and file == "bulletin.txt"
			system $EDITOR_PATH + "bulletin.txt"
			return
		else
			puts "Tu dois aller dans le dossier BULLETIN et modifier le fichier " +  "bulletin.txt".underline + " !"
		end
	end
end

def part2(nom_user)
ascii_art(1)
puts "\t>> BRAVO, TU AS RÉUSSI À T'INFILTRER DANS LE SYSTÈME INFORMATIQUE DE TON ÉCOLE !\n\tCOMMENÇONS PAR VOIR CE QU'IL Y A À L'INTÉRIEUR !<<\n".bold.blue
puts "	-> Pour voir tous les fichiers et dossiers qu'il y a dans le répertoire où tu es, tape la commande ".yellow.italic + "ls".underline.yellow.italic + ".\n".yellow.italic
boucle_part2("ls")
puts "\n\n	>> SUPER, COMME TU PEUX LE VOIR APRÈS LA FLÈCHE ROUGE, IL Y A UN DOSSIER \"ELEVES\", UN DOSSIER \"SECURITE\", UN DOSSIER \"ADMIN\" ET UN DOSSIER \"VIE SCOLAIRE\"".bold.blue
puts "	ET SI ON COMMENÇAIT PAR CHANGER TES NOTES, CE SERAIT SYMPAS D'AVOIR DES 20/20 PARTOUT !\n\tCOMMENCE PAR ALLER DANS LE DOSSIER ".bold.blue + "ELEVES".bold.blue.underline + " ! <<\n".bold.blue
puts "	-> Pour se déplacer dans un dossier, utilise la commande ".yellow.italic + "cd".yellow.italic.underline + " , suivi d'un espace, puis du nom du dossier où tu veux te déplacer !\n".yellow.italic
part2_cd_eleves()
ascii_art(1)
puts "	>> REGARDE TOUS LES ÉLÈVES QU'IL Y A ! CHERCHE TON DOSSIER AVEC TON NOM ET VA DEDANS ! <<\n".bold.blue
puts "	-> Pour voir tous les dossiers qu'il y a utilise la commande ".yellow.italic + "ls".yellow.italic.underline + " et pour accéder à ce dossier, utilise la commande ".yellow.italic + "cd".italic.yellow.underline + " !\n".yellow.italic
part2_namedir(nom_user)
ascii_art(1)
puts "	>> TRES BIEN, MAINTENANT QUE TU ES DANS TON DOSSIER, REGARDE TOUS LES FICHIERS QU'IL Y A. CE SONT TOUTES LES MATIERES QUE TU AS, DEDANS, IL Y A TA NOTE".bold.blue
puts "	A TOI DE JOUER POUR MODIFIER CES NOTES ET METTRE CELLES QUE TU VEUX ! <<\n".bold.blue
puts "\t-> Pour voir tous les fichiers qu'il y a dans le dossier où tu es, tape la commande ".yellow.italic + "ls".yellow.italic.underline + ".".yellow.italic
puts "	Pour modifier un fichier, tape la commande ".yellow.italic + "edit".yellow.italic.underline + ", un espace et le nom du fichier que tu veux modifier !\n".yellow.italic
puts "	Quand tu as terminé, entre la commande ".yellow.italic + "finish".yellow.italic.underline + " !".yellow.italic
part2_notes(nom_user)
ascii_art(1)
puts "	>> GENIAL, J'ESPERE QUE TU T'ES MIS PLEIN DE BONNES NOTES ! MAINTENANT, IL FAUT CHANGER LES APPRECIATIONS DE TON BULLETIN, PROFITES-EN POUR TE METTRE DES COMMENTAIRES COOLS !\n".bold.blue
puts "	-> Accede au dossier BULLETIN grâce à la commande ".yellow.italic + "cd".yellow.italic.underline + " puis édite ce fichier avec la commande ".yellow.italic + "edit".yellow.italic.underline + " !\n".yellow.italic
part2_last()
end

# 	----------------------------------------------- PART 3 -------------------------------
def part3_b1()
	while (1)
	display_prompt()
	input = STDIN.gets.chomp
		if input == "ecole"
			Dir.chdir "../../../"
			return
		else
			puts "Tape la commande " + "ecole".underline + " quand tu as terminé !"
		end
	end
end


def ask_mdp(file)
	print "Entrez le mot de passe pour entrer dans le dossier".underline + " :"
	input = STDIN.gets.chomp
	name = "." + file + ".txt"
	mdp = "../MOTS_DE_PASSE/" + name
	f = File.open(mdp, "r")
	ac_mdp = f.gets
	if ac_mdp == input
		Dir.chdir file
		puts "Bienvenue " + file + " !"
		return 1
	else
		puts "ERREUR : Mauvais mot de passe !"
		return 1
	end
end


def change_mdp(abs_path)
	Dir.foreach(abs_path + "ECOLE/SECURITE/UTILISATEURS") do |name|
		next if name == '.' or name == '..'
		path = abs_path + "ECOLE/SECURITE/MOTS_DE_PASSE/." + name.partition(" ").first + ".txt"
		new_mdp_path = abs_path + "ECOLE/SECURITE/UTILISATEURS/" + name + "/" + "nouveau_mdp.txt"
		if Dir.exist?(name)
		f = File.open(new_mdp_path, "r")
		new_mdp = f.gets
		if new_mdp != nil
			File.open(path, "w") do |f|
			f.write(new_mdp)
		end
	end
		end
	end
end


def admin_check(abs_path)
	print "Entrez le mot de passe pour la session admin".underline + " : "
	input = STDIN.gets.chomp
	if (input == "kbdr7#1")
		system abs_path + "admin.rb " + abs_path
	else
		puts "Mauvais mot de passe."
	end
end


# ---------------------------------- MAIN BOUCLE FAUX SHELL --------------------------

def main_boucle(name, abs_path)
	fl = 0
	while (1)
		change_mdp(abs_path)
		display_prompt()
		input = STDIN.gets.chomp
		if input != ""
			file = input.split(' ')[1..-1].join(' ')
			s1 = file.partition(" ").last
			s2 = s1.partition("/").first
			s3 = s2.match(/\"{,1}ecole/)
			if file == "ecole"
				file = abs_path + "ECOLE"
			elsif file.partition("/").first == "ecole" or s2.match(/\"{,1}ecole/)
				file = file.sub "ecole", (abs_path + "ECOLE")
				file = file.sub "ecole", (abs_path + "ECOLE")
			end
			extension = file.partition(".").last
		end
		if File.basename(Dir.getwd) == "UTILISATEURS" and input.partition(" ").first == "cd"
			if input.partition(" ").first == "cd" and  File.exist?(file) == true and file != ".." and file != "../"
				fl = ask_mdp(file)
			end
		end
		if input.partition(" ").first == "cd" and File.exist?(file) == true and File.basename(Dir.getwd) != "UTILISATEURS" and File.directory?(file) == true and file != ".."
				Dir.chdir file
		elsif input.partition(" ").first == "cd" and file == ".."
			if File.basename(Dir.getwd) == "ECOLE"
				puts "Attention, tu ne peux pas aller plus loin, il faut que tu restes dans le dossier ECOLE et les dossiers qu'il y a dedans !"
			else
				Dir.chdir ".."
			end
		elsif input.partition(" ").first == "ls"
			system "ls -G " + file

		elsif input.partition(" ").first == "edit" and  File.exist?(file) == true and extension != "controle" and File.directory?(file) == false
			if File.basename(Dir.getwd) == "MOTS_DE_PASSE"
				puts "Erreur: Vous n'avez pas l'autorisation de modifier directement les mots de passe !"
			elsif file == ".passwd"
					puts "Vous n'avez pas l'autorisation."
			else
				system $EDITOR_PATH + "\"" + file + "\""
			end
		elsif input == "pwd"
			new_path = Dir.getwd.sub abs_path, ""
			puts new_path
		elsif input == "ecole"
			Dir.chdir abs_path + "ECOLE"
		elsif input == "aide"
			system "less " + abs_path + "/aide"
		elsif input.partition(" ").first == "cat" and  File.exist?(file) == true
			system "cat " + file
			puts ""
		elsif input.partition(" ").first == "rm" and File.exist?(file) == true
			system "rm " + "\"" + file + "\""
		elsif input.partition(" ").first == "mkdir"
			system "mkdir " + "\"" + file + "\""
		elsif input.partition(" ").first == "touch"
			system "touch " + "\"" + file + "\""
		elsif input.partition(" ").first == "cp"
			#file2 = input.sub "cp ", ""
			system "cp " + file
		elsif input == "admin"
			admin_check(abs_path)
		elsif input.partition(" ").first == "chmod"
			system "chmod " + file
		elsif input.partition(" ").first == "mail" and file != ""
			system "mail " + file
		else
			if fl == 0
				puts "La commande a mal été formulée."
			end
		end
		fl = 0
	end
end



def part3(name, abs_path)
ascii_art(1)
puts "	>> QUAND TU AURAS FINI DE TOUT MODIFIER, tape la commande ".bold.blue + "ecole".bold.blue.underline + " ! <<\n".bold.blue
ENV['HOME'] = abs_path +  "ECOLE"
part3_b1()
ascii_art(1)
puts "\n	>> VOILA, MAINTENTANT TU AS LES BASES, À TOI DE JOUER ! <<\n".bold.blue
puts "	-> Tape la commande \"aide\" pour voir la liste de toutes les commandes et voir tout ce que tu peux faire !\n".yellow.italic
main_boucle(name, abs_path)
end

reset_sonnerie()
matieres = ["Maths", "Francais", "Histoire-Geographie", "Sport", "Arts-plastiques", "Musique", "LV1", "LV2", "SVT"]
abs_path = Dir.pwd + "/"
system "./create_all.rb"
Dir.chdir "ECOLE"
nom_user = debut()
nom_user = nom_user.partition(" ").first + "_" + nom_user.partition(" ").last
new_dir = "ELEVES/" + "\"" + nom_user + "\""
	system "mkdir -p " + new_dir
matieres.each do |matiere|
	note = rand(0..20)
	File.open("ELEVES/" + nom_user + "/" + matiere + ".txt","w") do |f|
		f.write(note.to_s)
	end
end
new_dir = "\"" + "ELEVES/" + nom_user + "/" + "\""
system "../bulletin.rb " + new_dir + " " + "\"" + nom_user + "\""
nom = nom_user.partition(" ").first  + ".txt"
new_f = abs_path + "ECOLE/VIE SCOLAIRE/HEURES_DE_COLLE/" + nom
File.open(new_f, "w") do |f|
	f.write("3")
end
new_f = "ELEVES/" + "\"" + nom_user + "\"" + "/emploi_du_temps.txt"
f_path = "ELEVES/" + "\"" + nom_user + "\"" + "/"
system "cp " + abs_path + "docs/emploi2 " + f_path
system "mv " + f_path + "/emploi2 " + new_f
part2(nom_user)
part3(nom_user, abs_path)
