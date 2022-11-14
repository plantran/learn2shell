# Initialize game's mandatory files and directories.
module InitGame
  require_relative 'teachers'
  require_relative 'students'

  # Generates all mandatory base files for the game.
  def self.init_game_all(force_reset: false)
    init_files_and_dirs(force_reset)
    t = Teachers.new
    t.init_all
    s = Students.new
    s.init_all
    Dir.chdir('ECOLE')
  end

  # Generates all mandatory directories and files for the game.
  def self.init_files_and_dirs(force_reset)
    system('rm -rf ECOLE') if force_reset
    dirs = ['ECOLE', 'ECOLE/ELEVES', 'ECOLE/VIE_SCOLAIRE/HEURES_DE_COLLE', 'ECOLE/SECURITE/UTILISATEURS',
            'ECOLE/SECURITE/MOTS_DE_PASSE', 'ECOLE/ADMIN']
    dirs.each do |dir_name|
      system("mkdir -p #{dir_name}")
    end
    return unless force_reset

    system('touch ECOLE/ADMIN/.passwd')
    File.open('ECOLE/ADMIN/.passwd', 'w') { |f| f.puts(ENV['ADMIN_PASSWORD']) }
    system('chmod 000 ECOLE/ADMIN/.passwd')
  end
  private_class_method :init_files_and_dirs
end
