require 'csv'

@students = []

def print_menu
  puts "\nMAIN MENU"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "5. Print Source Code"
  puts "9. Exit\n "
end

def interactive_menu
  loop do
  print_menu
  process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
      puts "Student input completed"
    when "2"
      show_students
    when "3"
      puts "Please enter filename (eg students.csv)"
      save_students(STDIN.gets.chomp)
      puts "student list saved"
    when "4"
      puts "Please enter filename (eg students.csv)"
      load_students(STDIN.gets.chomp)
      puts "loaded additional students from file, new student total: #{@students.count}"
    when "5"
      print_source_code
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "(To finish, just hit return twice)"
  name = STDIN.gets.chomp
  
  while !name.empty? do
    cohort = "november"
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  # print list of all students
  puts "Students by index number: \n "
  @students.each_with_index { |student, index|
    puts "#{index+1}.#{student[:name]} (#{student[:cohort]} cohort)"
  }

  # sort students by cohort and print
  cohorts_filled = {}
  @students.each { |student|
    cohorts_filled[student[:cohort]] == nil ? cohorts_filled[student[:cohort]] = [student[:name]] : cohorts_filled[student[:cohort]].push(student[:name])
  }

  puts " \nStudents by cohort: \n "
  cohorts_filled.each { |key, value|
    puts "The #{key.to_s.capitalize} cohort:"
    value.each { |name|
      puts name
    }
    puts ""
  }
end

def print_footer
  @students.count < 2 ? student_plural = "student" : student_plural = "students"
  string = "Overall, we have #{@students.count} great #{student_plural}"
  puts string.center(50,"*")
  puts ""
end

def save_students(filename)
  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
end

def load_students(filename)
  CSV.foreach(filename, "r") do |row|
      name, cohort = row[0], row[1]
      add_student(name, cohort)
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    filename = "students.csv"
  end
  if File.exist?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end
 
def print_source_code
  puts "Source code: \n"
  puts File.read(__FILE__)
end

try_load_students
interactive_menu



