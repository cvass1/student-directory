

def input_students(availabile_cohorts)
  puts "Please enter the names of the students"
  puts "(To finish, just hit return twice)"

  students = []

  puts "student name: "
  name = gets.gsub("\n","")
  
  while !name.empty? do
    cohort = "undefined"
    while availabile_cohorts[cohort.to_sym] == nil do
      puts "Enter cohort month eg november:"
      cohort = gets.chomp
      cohort == "" ? cohort = :november : cohort
    end

    students << {name: name,
      cohort: cohort,
      hobby: :gym,
      country_of_birth: :UK,
      height: 1.5}
    puts "Now we have #{students.count} students"
    puts "student name:"
    name = gets.chomp
  end

  students
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  # print list of all students
  puts "Students by index number: \n "
  students.each_with_index { |student, index|
    puts "#{index+1}.#{student[:name]} (#{student[:cohort]} cohort)"
  }

  # sort students by cohort and print
  cohorts_filled = {}
  students.each { |student|
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

def print_footer(names)
  names.count < 2 ? student_plural = "student" : student_plural = "students"
  string = "Overall, we have #{names.count} great #{student_plural}"
  puts string.center(50,"*")
  puts ""
end

def interactive_menu
  cohorts = {
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
  students = []
  loop do
  # 1. print the menu and ask the user what to do
  puts "\nMAIN MENU"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit\n "
  # 2. read the input and save it into a variable
  selection = gets.chomp
  # 3. do what the user has asked
  case selection
  when "1"
    students = input_students(cohorts)
  when "2"
    if students.length > 0
      print_header
      print(students)
      print_footer(students)
    end
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
end
  end
end 


interactive_menu
