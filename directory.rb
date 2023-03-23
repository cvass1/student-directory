
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
  puts ""
  puts string.center(50,"*")
end

# temporarily using hardcoded list to test code in Examples -
# will switch back to input_students later

students = input_students(cohorts)
students_old = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :may},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :june},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :june},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :may}
]


if students.length > 0
  print_header
  print(students)
  print_footer(students)
end
