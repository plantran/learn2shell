#!/usr/bin/ruby
# encoding: utf-8


def get_note(path, matiere)
file = File.open(path + matiere )
note = file.gets
	if note.length == 1
		note = note + " "
	end
return note
end

def get_appreciation(notes)
	note = notes.to_i
	if note <= 5
		appreciation = "Tu dois faire des efforts !"
	elsif 5 < note and note <= 10
		appreciation = "Travail correct, mais tu peux mieux faire !"
	elsif 10 < note and note <= 15
		appreciation = "Bon travail, continue comme ça !"
	elsif note > 15
		appreciation = "Excellent travail ! Continue sur cette voie !"
	end
	return appreciation
end


path = ARGV[0]
prenom = ARGV[1]
system "mkdir -p " + "\"" + path + "\"" + "BULLETIN"
tmp_path = path + "BULLETIN/"

	File.open(tmp_path + "bulletin.txt","w") do |f|
		f.write("     ====================================================================================================\n")
		f.write("     COLLEGE 42                      | ELEVE : " + prenom + "\n")
		f.write("                                     |\n")
		f.write("     96 Boulevard Bessieres          |\n")
		f.write("     75017                           | ANNEE SCOLAIRE : 2016-2017\n")
		f.write("     Paris                           | TRIMESTRE : 1\n")
		f.write("     ====================================================================================================\n")
		f.write("     ====================================================================================================\n")
		f.write("            MATIERE                  |   NOTE   |                     APPRECIATION   \n")
		f.write("     ====================================================================================================\n")
		note1 = get_note(path, "Francais.txt")
		appreciation = get_appreciation(note1)
		f.write("            FRANCAIS                 |   " + note1 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note2 = get_note(path, "Maths.txt")
		appreciation = get_appreciation(note2)
		f.write("            MATHEMATIQUES            |   " + note2 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note3 = get_note(path, "Histoire-Geographie.txt")
		appreciation = get_appreciation(note3)
		f.write("            HISTOIRE-GEOGRAPHIE      |   " + note3 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note4 = get_note(path, "SVT.txt")
		appreciation = get_appreciation(note4)
		f.write("            SVT                      |   " + note4 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note5 = get_note(path, "LV1.txt")
		appreciation = get_appreciation(note5)
		f.write("            LV1                      |   " + note5 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note6 = get_note(path, "LV2.txt")
		appreciation = get_appreciation(note6)
		f.write("            LV2                      |   " + note6 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note7 = get_note(path, "Arts-plastiques.txt")
		appreciation = get_appreciation(note7)
		f.write("            ARTS PLASTIQUES          |   " + note7 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note8 = get_note(path, "Musique.txt")
		appreciation = get_appreciation(note8)
		f.write("            MUSIQUE                  |   " + note8 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		note9 = get_note(path, "Sport.txt")
		appreciation = get_appreciation(note9)
		f.write("            SPORT                    |   " + note9 + "     |    " + appreciation + "\n")
		f.write("     ====================================================================================================\n")
		somme = (note1.to_i + note2.to_i + note3.to_i + note4.to_i + note5.to_i + note6.to_i + note7.to_i + note8.to_i + note9.to_i).to_i
		moyenne = somme / 9
		f.write("            MOYENNE GENERALE         |   " + moyenne.to_s + "     |\n")
	end