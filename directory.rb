
@students = []

def input_students
  availabile_cohorts = {
    january: 1,
    february: 2,
    march: 3,
    april: 4,
    may: 5,
    june: 6,
    july: 7,
    august: 8,
    september: 9,
    october: 10,
    november: 11,
    december: 12,
  }

  puts "Please enter the names of the students"
  puts "(To finish, just hit return twice)"


  puts "student name: "
  name = gets.gsub("\n","")
  
  while !name.empty? do
    cohort = "undefined"
    while availabile_cohorts[cohort.to_sym] == nil do
      puts "Enter cohort month eg november:"
      cohort = gets.chomp
      cohort == "" ? cohort = :november : cohort
    end

    @students << {name: name,
      cohort: cohort,
      hobby: :gym,
      country_of_birth: :UK,
      height: 1.5}
    puts "Now we have #{@students.count} students"
    puts "student name:"
    name = gets.chomp
  end

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


def print_menu
  puts "\nMAIN MENU"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit\n "
end


def show_students
  print_header
  print_students_list
  print_footer
end


def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def interactive_menu
  loop do
  print_menu
  process(gets.chomp)
  end
end 



interactive_menu
