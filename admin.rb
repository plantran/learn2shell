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



puts "Bienvenue dans le mode admin. Pour pouvez quitter à tout moment en tapant la commande exit."
puts "Tapez \"aide\" pour voir ce que vous pouvez faire."
path = ARGV[0] + "admin/"

def display_status(path)
	tab = Array.new
	s = String.new
	i = 0
	File.open(path + "set_sonneries", "r") do |f|
		s << f.read
	end
	tab = s.split("\n")
	tab.each do |t|
		if i == 0
			sonnerie = t.partition("=").last
			sonnerie = sonnerie.strip
			puts "La sonnerie de cours sonnera toutes les " + sonnerie.bold.pink + " minutes."
		elsif i == 1
			alarme = t.partition("=").last
			alarme = alarme.strip
			puts "L'alarme incendie sonnera " + alarme.bold.pink + " fois par mois."
		elsif i == 2
			musique = t.partition("=").last
			musique = musique.strip
			puts "La musique de la sonnerie de cours est " + musique.bold.pink + "."
		end	
		i += 1	
	end
end

while (1)
	print "Répertoire actuel: ADMIN -> ".green.bold
	input  = STDIN.gets.chomp
	if input != ""
		file = input.split(' ')[1..-1].join(' ')
	end
	if input == "exit"
		puts "Vous quittez le mode administrateur..."
		sleep (2)
		exit
	elsif input.partition(" ").first == "mail" and file != ""
		system "mail " + file
	elsif input.partition(" ").first == "ls"
		system "ls -G " + file + " " + path
	elsif input.partition(" ").first == "edit" and File.exist?(path + file) == true
		system $EDITOR_PATH + path  +  file 
	elsif input.partition(" ").first == "cat" and File.exist?(path + file) == true
		system "cat " + path + file
	elsif input == "status"
		display_status(path)
	elsif input == "aide"
		path2 = ARGV[0] + "aide_admin"
		system "less " + path2
	else
		puts "La commande a mal été formulée."
	end
end
