#!/usr/bin/env ruby


def reset_sonnerie
	File.open("admin/set_sonneries","w") do |f|
		f.write("sonnerie pause = 55\n")
		f.write("alarme incendie = 1\n")
		f.write("son sonnerie = sonnerie normale\n")
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
		# display_prompt()
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

		elsif input.partition(" ").first == "edit" and  File.exist?(file) == true and extension != "controle" and File.directory?(file) == false
			if File.basename(Dir.getwd) == "MOTS_DE_PASSE"
				puts "Erreur: Vous n'avez pas l'autorisation de modifier directement les mots de passe !"
			elsif file == ".passwd"
					puts "Vous n'avez pas l'autorisation."
			else
				system $EDITOR_PATH + "\"" + file + "\""
			end
			puts new_path

		elsif input == "admin"
			admin_check(abs_path)
	end
end



def part3(name, abs_path)
	main_boucle(name, abs_path)
end

reset_sonnerie()




part3(nom_user, abs_path)
