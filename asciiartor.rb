# TODO: Make Singleton!
class Asciiartor
  require_relative 'outputer'

  def initialize(kind)
    @kind = kind
    init_from_kind
  end

  def display(with_clear: true)
    system('clear') if with_clear
    puts @ascii_art
  end

  def make_ascii_from_file(editor)
    lambda do
      text = File.read("#{__dir__}/#{@file}")
      editor.call(text)
    end
  end

  private

  def init_from_kind
    kind = which_kind
    @file = kind[:file]
    @msg = kind[:msg]
    @ascii_art = kind[:init_method].call
  end

  def which_kind
    access_authorized = proc { |text| text.gsub(/{{ msg }}/, @msg.upcase.green) }
    access_denied = proc { |text| text.gsub(/{{ msg }}/, @msg.upcase.red) }
    access_authorized_welcome = proc { |text| text.green }
    kinds = { computer_authorized: { file: 'ascii_arts/computer_authorized.txt', msg: 'Accès autorisé',
                                     init_method: make_ascii_from_file(access_authorized) },
              computer_denied: { file: 'ascii_arts/computer_denied.txt', msg: 'Accès refusé',
                                 init_method: make_ascii_from_file(access_denied) },
              access_authorized_welcome: { file: 'ascii_arts/access_authorized_welcome.txt', msg: 'Accès refusé',
                                           init_method: make_ascii_from_file(access_authorized_welcome) } }.freeze

    kinds[@kind]
  end
end
