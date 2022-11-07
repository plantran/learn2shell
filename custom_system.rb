# Provides custom methods for system calls

module CustomSystem
  AUTHORIZED_COMMANDS = %w[ls edit].freeze

  def prompt_and_user_input(downcased: true)
    print('-> '.bold.green)
    inp = $stdin.gets.chomp&.strip
    downcased ? inp.downcase : inp
  end

  def execute_custom_command(cmd, *args)
    p "CMD = #{cmd}"
    p "ARGS = "
    p args
    p '--------------'
  end
end
