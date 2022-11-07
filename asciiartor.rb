module Asciiartor
  require_relative 'outputer'

  def self.access_denied(with_clear: true)
    msg = 'Accès refusé'
    text = File.read("#{__dir__}/ascii_arts/computer_denied.txt")
    system('clear') if with_clear
    puts text.gsub(/{{ msg }}/, msg.upcase.red)
  end

  def self.access_authorized(with_clear: true)
    msg = 'Accès autorisé'
    text = File.read("#{__dir__}/ascii_arts/computer_authorized.txt")
    system('clear') if with_clear
    puts text.gsub(/{{ msg }}/, msg.upcase.green)
  end

  def self.access_authorized_welcome
    text = File.read("#{__dir__}/ascii_arts/access_authorized_welcome.txt")
    puts text.green
  end
end
