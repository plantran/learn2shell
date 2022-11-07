# Creates all teachers files for initialization.
class Teachers
  require 'csv'

  def init_all
    fetch_teachers
    create_teachers_passwords
    create_teachers_users
    create_tests
  end

  private

  def fetch_teachers
    @teachers = []
    CSV.foreach('data/teachers_info.csv', headers: true, col_sep: ',') do |row|
      @teachers << { name: row['name'], topic: row['topic'], password: row['password'],
                     test_path: row['test_path'] }
    end
  end

  def create_teachers_passwords
    @teachers.each do |teacher|
      first_name, last_name = teacher[:name].split(' ').map(&:downcase)
      dir_mdp = "#{ENV['PASSWORD_PATH']}/.#{first_name}_#{last_name}.txt"
      File.open(dir_mdp, 'w') { |f| f.write(teacher[:password]) }
    end
  end

  def create_teachers_users
    @teachers.each do |teacher|
      first_name, last_name = teacher[:name].split(' ').map(&:downcase)
      new_dir = "#{ENV['USERS_PATH']}/#{first_name}_#{last_name}"
      system "mkdir -p #{new_dir}"
      system "touch #{new_dir}/nouveau_mdp.txt"
    end
  end

  def create_tests
    @teachers.each do |teacher|
      next unless teacher[:test_path]

      first_name, last_name = teacher[:name].split(' ').map(&:downcase)
      new_dir = "#{ENV['USERS_PATH']}/#{first_name}_#{last_name}"
      system "cp docs/#{teacher[:test_path]} #{new_dir}/"
    end
  end
end
