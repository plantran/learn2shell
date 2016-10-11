#!/usr/bin/ruby

rand_fnames = ["Lea Martin", "Jade Bernard", "Manon Dubois", "Louise Thomas", "Zoe Petit", "Ines Faure", "Lilou Lefevre", "Lena Scholl", "Sarah Foussere", "Camille Lopez", "Maelys Joly", "Lina Blanc", "Eva Macaigne", "Louna Morin", "Clara Sanchez", "Alice Boyer", "Romane Nguyen"]
rand_mnames = ["Enzo Roche", "Louis Tarriel", "Gabriel Leroux", "Jules Edelin", "Timeo Vidal", "Hugo Lecomte", "Arthur Baudel", "Ethan Berger", "Raphael Renard", "Tom Bombadil", "Noah Charles", "Mathis Da Silva", "Theo Fleury", "Adam Menard", "Nolan Le Gall", "Clement Riviere", "Abdou Kerkeb"]

matieres = ["Maths", "Francais", "Histoire-Geographie", "Sport", "Arts-plastiques", "Musique", "LV1", "LV2", "SVT"]


utilisateurs = {
	:prof1 => {:nom => "Francois Roublon", 		:matiere => "Francais", :mdp => "zsexdr1"},
	:prof2 => {:nom => "Eric Delafre", 			:matiere => "Maths", :mdp => "xdrcft3"},
	:prof3 => {:nom => "Elodie Etourneau", 		:matiere => "Francais", :mdp => "cfttfc3"},
	:prof4 => {:nom => "Maeva Fares", 			:matiere => "Maths", :mdp => "vgyygv4"},
	:prof5 => {:nom => "Max Bourdi", 			:matiere => "Histoire-Geographie", :mdp => "eszxdr6"},
	:prof6 => {:nom => "Amhed Barakat", 		:matiere => "Sport", :mdp => "okmbhu3"},
	:prof7 => {:nom => "Jean Soummier", 		:matiere => "Histoire-Geographie", :mdp => "njiuhg7"},
	:prof8 => {:nom => "Valerie Van der Meulen",:matiere => "Sport", :mdp => "njiokl0"},
	:prof9 => {:nom => "Juliette Soisson", 		:matiere => "Arts-plastiques", :mdp => "xdresv7"},
	:prof10 => {:nom => "Lise Hautard", 		:matiere => "Musique", :mdp => "bhuijn5"},
	:prof11 => {:nom => "Yvan Champeroux", 		:matiere => "Arts-plastiques", :mdp => "cvbnhu2"},
	:prof12 => {:nom => "Nicolas Peroteau", 	:matiere => "Musique", :mdp => "njiuhbt"},
	:prof13 => {:nom => "Franny Kilab", 		:matiere => "LV1", :mdp => "fghjkl8"},
	:prof14 => {:nom => "Veronique Grangeon", 	:matiere => "LV2", :mdp => "cgydht6"},
	:prof15 => {:nom => "Denis Martin", 		:matiere => "LV1", :mdp => "werfgt3"},
	:prof16 => {:nom => "Mathieu Manley", 		:matiere => "LV2", :mdp => "qwertgh2"},
	:prof17 => {:nom => "Justine Juste", 		:matiere => "SVT", :mdp => "qwdfgh7"},
	:prof18 => {:nom => "Corinne Stermann", 	:matiere => "SVT", :mdp => "bnhjui9"},
}

system "mkdir -p ECOLE"
system "mkdir -p ECOLE/ELEVES"
system "mkdir -p ECOLE/\"VIE SCOLAIRE\"/\"HEURES_DE_COLLE\""
system "mkdir -p ECOLE/SECURITE/UTILISATEURS"
system "mkdir -p ECOLE/SECURITE/\"MOTS_DE_PASSE\""
system "mkdir -p ECOLE/ADMIN"
system "touch ECOLE/ADMIN/.passwd"
system "printf \"kbdr7\$v23#1\" > ECOLE/ADMIN/.passwd"
system "chmod 000 ECOLE/ADMIN/.passwd"

i = 0

def 	controle_matiere(infos)

	infos.each do |nom, matiere|
		nom = infos[:nom].partition(" ").first + "_" + infos[:nom].partition(" ").last
		new_dir = "\"" + "ECOLE/SECURITE/UTILISATEURS/"  + nom + "\"" + "/"
		if infos[:matiere] == "Francais"
			if infos[:nom] == "Francois Roublon"
				system "cp docs/francais/devoir_francais1.controle " + new_dir
			elsif infos[:nom] == "Elodie Etourneau"
				system "cp docs/francais/devoir_francais2.controle " + new_dir
			end
		elsif infos[:matiere] == "Maths"
			if infos[:nom] == "Eric Delafre"
				system "cp docs/maths/devoir_maths1.controle " + new_dir
			elsif infos[:nom] == "Maeva Fares"
				system "cp docs/maths/devoir_maths2.controle " + new_dir
			end
		elsif infos[:matiere] == "Histoire-Geographie"
			if infos[:nom] == "Max Bourdi"
				system "cp docs/histoire/devoir_histoire1.controle " + new_dir
			elsif infos[:nom] == "Jean Soummier"
				system "cp docs/histoire/devoir_histoire2.controle " + new_dir
			end
		elsif infos[:matiere] == "Musique"
			if infos[:nom] == "Lise Hautard"
				system "cp docs/musique/devoir_musique1.controle " + new_dir
			elsif infos[:nom] == "Nicolas Peroteau"
				system "cp docs/musique/devoir_musique2.controle " + new_dir
			end
		elsif infos[:matiere] == "LV1"
			system "cp docs/lv1/devoir_lv1.controle " + new_dir
		elsif infos[:matiere] == "LV2"
			if infos[:nom] == "Veronique Grangeon"
				system "cp docs/lv2/devoir_lv21.controle " + new_dir
			elsif infos[:nom] == "Mathieu Manley"
				system "cp docs/lv2/devoir_lv22.controle " + new_dir
			end
		elsif infos[:matiere] == "SVT"			
			if infos[:nom] == "Justine Juste"
				system "cp docs/svt/devoir_svt1.controle " + new_dir
			elsif infos[:nom] == "Corinne Stermann"
				system "cp docs/svt/devoir_svt2.controle " + new_dir
			end
		end
	end
end


# ----------------------- CREATION DES DOSSIERS PROFS  ---------------------


utilisateurs.each do |prof, infos|
	infos.each do |nom, matiere| 
		prenom = infos[:nom].partition(" ").first
		nom = infos[:nom].partition(" ").last
		dir_mdp =  "ECOLE/SECURITE/MOTS_DE_PASSE/."  +  prenom + "_"  + nom + ".txt" 
		File.open(dir_mdp,"w") do |f|
		f.write(infos[:mdp])
		end
		nom = infos[:nom].partition(" ").first + "_" + infos[:nom].partition(" ").last
		new_dir = "\"" + "ECOLE/SECURITE/UTILISATEURS/"  + nom + "\""
		system "mkdir -p " + new_dir
		new_dir = new_dir + "/" + "nouveau_mdp.txt"
		system "touch " + new_dir
	end
	controle_matiere(infos)
end



# -------------------------- CREATION DES DOSSIERS ELEVES ----------------------


rand_mnames.each do |names|
	nom = names.partition(" ").first + "_" + names.partition(" ").last
	new_dir = "ECOLE/ELEVES/" + "\"" + nom + "\""
	system "mkdir -p " + new_dir
	if i % 2 == 0
		heures = rand(1..4)
		nom2 = names.partition(" ").first + "_" + names.partition(" ").last + ".txt"
		new_f = "ECOLE/VIE SCOLAIRE/HEURES_DE_COLLE/" + nom2
		File.open(new_f, "w") do |f|
			f.write(heures.to_s)
		new_f = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/emploi_du_temps.txt"
		f_path = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/"
		system "cp docs/emploi1 " + f_path
		system "mv " + f_path + "/emploi1 " + new_f
		end
	else
		new_f = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/emploi_du_temps.txt"
		f_path = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/"
		system "cp docs/emploi2 " + f_path
		system "mv " + f_path + "/emploi2 " + new_f
	end
	i += 1
	matieres.each do |matiere|
		note = rand(0..20)
		File.open("ECOLE/ELEVES/" + nom + "/" + matiere + ".txt" ,"w") do |f|
			f.write(note.to_s)
		end
	end
	system "./bulletin.rb " + "\"" + "ECOLE/ELEVES/" + nom + "/" + "\"" + " " + "\"" + nom + "\""
end

i = 0

rand_fnames.each do |names|
	nom = names.partition(" ").first + "_" + names.partition(" ").last
	new_dir = "ECOLE/ELEVES/" + "\"" + nom + "\""
	system "mkdir -p " + new_dir
	if i % 2 == 0
		heures = rand(1..4)
		nom2 = names.partition(" ").first + "_" + names.partition(" ").last + ".txt"
		new_f = "ECOLE/VIE SCOLAIRE/HEURES_DE_COLLE/" + nom2 
		File.open(new_f, "w") do |f|
			f.write(heures.to_s)
		end
		new_f = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/emploi_du_temps.txt"
		f_path = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/"
		system "cp docs/emploi1 " + f_path
		system "mv " + f_path + "/emploi1 " + new_f
	else
		new_f = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/emploi_du_temps.txt"
		f_path = "ECOLE/ELEVES/" + "\"" + nom + "\"" + "/"
		system "cp docs/emploi2 " + f_path
		system "mv " + f_path + "/emploi2 " + new_f
	end
	i += 1
	matieres.each do |matiere|
		note = rand(0..20)
		matiere = matiere + ".txt"
		File.open("ECOLE/ELEVES/" + nom + "/" + matiere,"w") do |f|
			f.write(note.to_s)
		end
	end
	system "./bulletin.rb " + "\"" + "ECOLE/ELEVES/" + nom + "/" + "\"" + " " + "\"" + nom + "\""
end