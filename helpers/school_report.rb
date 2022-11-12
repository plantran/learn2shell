# Generates random school report for a given student.
class SchoolReport
  TOPICS = %w[maths francais histoire-geo sport arts-plastiques musique lv1 lv2
              svt].freeze

  def initialize(student)
    @student = student
    @first_name, @last_name = @student[:name].split(' ')
    @name = "#{@first_name.downcase}_#{@last_name.downcase}"
    make_grades
    create_report
  end

  private

  # Generates random grades from 0 to 20 for each topic.
  def make_grades
    @grades = {}
    TOPICS.each do |topic|
      grade = rand(0..20)
      @grades[topic.to_sym] = grade
    end
  end

  # Creates a school report for a student based on random grades.
  def create_report
    report_text = create_header
    TOPICS.each do |topic|
      report_text += create_grade_report(topic)
    end
    report_text += create_footer
    save_report(report_text)
  end

  # Converts a grade to a human readable comment.
  def comment_from_grade(grade)
    case grade
    when 0..5
      'Tu dois faire des efforts !'
    when 6..10
      'Travail correct, mais tu peux mieux faire !'
    when 11..15
      'Bon travail, continue comme ça !'
    when 16..20
      'Excellent travail ! Continue sur cette voie !'
    end
  end

  # Generates school report's header
  def create_header
    dates = "#{Date.today.year}-#{Date.today.year + 1}"
    <<~TXT
      #{make_separator}
          COLLEGE 42                      | ELEVE : #{@first_name}
                                          |
          96 Boulevard Bessieres          |
          75017                           | ANNEE SCOLAIRE : #{dates}
          Paris                           | TRIMESTRE : 1
      #{make_separator}\n#{make_separator}
                    MATIERE               |   NOTE   |                     APPRECIATION
      #{make_separator}
    TXT
  end

  # Creates a single school report row for a specific topic.
  def create_grade_report(topic)
    grade = @grades[topic.to_sym]
    <<~TXT
      #{make_padding(topic.upcase, :col1)}|#{make_padding(grade.to_s, :col2)}|\
      #{make_padding(comment_from_grade(grade), :col3)}
      #{make_separator}
    TXT
  end

  # Generates school report's footer.
  def create_footer
    avg = @grades.values.sum / @grades.size
    "#{make_padding('MOYENNE GENERALE', :col1)}|#{make_padding(avg.to_s, :col2)}|\n"
  end

  # Generates a separating line for the school report.
  def make_separator
    " #{'=' * 100}"
  end

  # Ensures uniformity of school record by forcing a padding on columns.
  def make_padding(str, kind)
    p_reference = { col1: 36, col2: 10, col3: 53 }
    padding = (p_reference[kind] - str.size) / 2
    p_remain = (p_reference[kind] - str.size) % 2
    "#{' ' * padding}#{str}#{' ' * padding}#{' ' * p_remain}"
  end

  # Saves generated school report to student's direcory.
  def save_report(report_text)
    bulletin_path = "#{__dir__}/../#{ENV['STUDENTS_PATH']}/#{@name}"
    File.open("#{bulletin_path}/bulletin.txt", 'w') { |f| f.write(report_text) }
  end
end
