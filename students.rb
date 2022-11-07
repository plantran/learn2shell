# Creates all students files for initialization.
class Students
  require 'csv'
  require_relative 'school_report'

  def init_for_one(full_name)
    @students = [{ name: full_name, detention: 3, tt_path: 'emploi2.txt' }]
    create_students_timetable
    create_detentions
    create_school_reports
  end

  def init_all
    fetch_students
    create_students_timetable
    create_detentions
    create_school_reports
  end

  private

  def fetch_students
    @students = []
    CSV.foreach('data/students_info.csv', headers: true, col_sep: ',') do |row|
      @students << { name: row['name'], detention: row['detention'], tt_path: row['tt_path'] }
    end
  end

  def create_students_timetable
    @students.each do |student|
      name = student[:name].split(' ').map(&:downcase).join('_')
      student_path = "#{ENV['STUDENTS_PATH']}/#{name}"
      system "mkdir -p #{student_path}"
      system "cp docs/#{student[:tt_path]} #{student_path}/emploi_du_temps.txt"
    end
  end

  def create_detentions
    @students.each do |student|
      next if student[:detention].to_i.zero?

      name = student[:name].split(' ').map(&:downcase).join('_')
      file_path = "#{ENV['DETENTIONS_PATH']}/#{name}"
      File.open(file_path, 'w') { |f| f.write(student[:detention]) }
    end
  end

  def create_school_reports
    @students.each do |student|
      SchoolReport.new(student)
    end
  end
end
