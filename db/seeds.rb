# ORL database

# users = [{ email: 'face.david@recognition.com', password: 'password', password_confirmation: 'password', user_class: 'david', first_name: 'David', last_name: 'Nuna' }]
# (1..40).each do |subject_number|
#   users << { email: "face.subject_#{subject_number}@recognition.com", password: 'password', password_confirmation: 'password', user_class: "subject_#{subject_number}", first_name: 'Subject', last_name: "#{subject_number}"}
# end
#
# User.create!(users)
# puts "#{User.count} users created!"
#
# User.all.each do |user|
#   user.user_image.attach(io: File.open("app/assets/#{user.user_class}.jpg"), filename: "#{user.user_class}.jpg")
#   puts "app/assets/#{user.user_class}.jpg"
# end

# YALE database

users = [
  { email: 'quiz.teacher_1@fr.com', password: 'password', password_confirmation: 'password', user_class: 'teacher', first_name: 'First', last_name: 'Teacher', admin: true },
  { email: 'quiz.teacher_2@fr.com', password: 'password', password_confirmation: 'password', user_class: 'teacher', first_name: 'Second', last_name: 'Teacher', admin: true },
  { email: 'quiz.david@fr.com', password: 'password', password_confirmation: 'password', user_class: 'david', first_name: 'David', last_name: 'Nuna' }
]
(1..38).each do |subject_number|
  users << { email: "quiz.subject_#{subject_number}@fr.com", password: 'password', password_confirmation: 'password', user_class: "subject_#{subject_number}", first_name: 'Subject', last_name: "#{subject_number}"}
end

User.create!(users)
puts "#{User.count} users created!"

# To modify!
User.all.each do |user|
  user.user_image.attach(io: File.open("app/assets/#{user.user_class}.jpg"), filename: "#{user.user_class}.jpg")
  puts "app/assets/#{user.user_class}.jpg"
end

# Quiz 1
quiz_1 = Quiz.create!(user_id: 1, name: 'Geography of Europe', difficulty: 0)
questions_1 = [
  { quiz: quiz_1, name: 'What is the smallest country in Europe?', answer_1: 'Monaco', answer_2: 'Vatican City', answer_3: 'Liechtenstein', answer_4: 'San Marino', correct_answer: 'Vatican City' },
  { quiz: quiz_1, name: 'What is the capital of Croatia?', answer_1: 'Pristina', answer_2: 'Tirana', answer_3: 'Sarajevo', answer_4: 'Zagreb', correct_answer: 'Zagreb' },
  { quiz: quiz_1, name: 'Which peak is the highest active volcano in Europe?', answer_1: 'Vesuvius', answer_2: 'Mount Etna', answer_3: 'Klyuchevskaya Sopk Volcano', answer_4: 'Beerenberg', correct_answer: 'Mount Etna' },
  { quiz: quiz_1, name: 'What is the longest running river in Europe?', answer_1: 'Danube River', answer_2: 'Dnieper River', answer_3: 'Elbe River', answer_4: 'Volga River', correct_answer: 'Volga River' },
  { quiz: quiz_1, name: 'What is the capital of Russia?', answer_1: 'Moscow', answer_2: 'St. Petersburg', answer_3: 'Volgograd', answer_4: 'Omsk', correct_answer: 'Moscow' },
  { quiz: quiz_1, name: 'What European country consists of a boot-shaped peninsula surrounded by four seas?', answer_1: 'Scotland', answer_2: 'Greece', answer_3: 'Italy', answer_4: 'Portugal', correct_answer: 'Italy' },
  { quiz: quiz_1, name: 'Where will you find Stonehenge?', answer_1: 'England', answer_2: 'Sweden', answer_3: 'Iceland', answer_4: 'Malta', correct_answer: 'England' },
  { quiz: quiz_1, name: 'Copenhagen is in what European country?', answer_1: 'Norway', answer_2: 'Finland', answer_3: 'Sweden', answer_4: 'Denmark', correct_answer: 'Denmark' },
  { quiz: quiz_1, name: 'La Sagrada Familia is located in which city?', answer_1: 'Madrid', answer_2: 'Prague', answer_3: 'Barcelona', answer_4: 'Florence', correct_answer: 'Barcelona' },
  { quiz: quiz_1, name: 'What\'s the largest city in Europe by population?', answer_1: 'Madrid', answer_2: 'Paris', answer_3: 'Moscow', answer_4: 'London', correct_answer: 'Moscow' }
]
Question.create!(questions_1)

# Quiz 2
quiz_2 = Quiz.create!(user_id: 1, name: 'Romanian History', difficulty: 1)
questions_2 = [
  { quiz: quiz_2, name: 'Which Roman emperor first conquered present-day Romania?', answer_1: 'Augustus', answer_2: 'Nero', answer_3: 'Caligula', answer_4: 'Trajan', correct_answer: 'Trajan' },
  { quiz: quiz_2, name: 'Carol I and II are related to which European royal house?', answer_1: 'Roumanov', answer_2: 'Bourbon', answer_3: 'Hohenzollern', answer_4: 'Habsburg', correct_answer: 'Hohenzollern' },
  { quiz: quiz_2, name: 'Stephen the Great was the ruler of?', answer_1: 'Moldavia', answer_2: 'Hungary', answer_3: 'Transylvania', answer_4: 'Habsburg', correct_answer: 'Moldavia' },
  { quiz: quiz_2, name: 'When did the Romanian Revolution happen?', answer_1: '1918', answer_2: '1859', answer_3: '1989', answer_4: '1848', correct_answer: '1989' },
  { quiz: quiz_2, name: 'When did Romania enter World War 1?', answer_1: '1914', answer_2: '1916', answer_3: '1918', answer_4: '1939', correct_answer: '1916' },
  { quiz: quiz_2, name: 'In what year did Romania join N.A.T.O?', answer_1: '2007', answer_2: '1989', answer_3: '2004', answer_4: '1991', correct_answer: '2004' }
]
Question.create!(questions_2)

# Quiz 3
quiz_3 = Quiz.create!(user_id: 2, name: 'Data Structures and Algorithms', difficulty: 1)
questions_3 = [
  { quiz: quiz_3, name: 'What is the worst case time complexity of linear search algorithm?', answer_1: 'Ο(1)', answer_2: 'Ο(n)', answer_3: 'Ο(n2)', answer_4: 'Ο(logn)', correct_answer: 'Ο(n)' },
  { quiz: quiz_3, name: 'Quick sort algorithm is an example of?', answer_1: 'Greedy approach', answer_2: 'Dynamic Programming', answer_3: 'Divide and conquer', answer_4: 'Improved binary search', correct_answer: 'Divide and conquer' },
  { quiz: quiz_3, name: 'Quick sort running time depends on the selection of?', answer_1: 'size of array', answer_2: 'pivot element', answer_3: 'sequence of values', answer_4: 'nothing', correct_answer: 'pivot element' },
  { quiz: quiz_3, name: 'If we choose Prim\'s Algorithm for uniquely weighted spanning tree instead of Kruskal\'s Algorithm, then:', answer_1: 'we\'ll get a different spanning tree', answer_2: 'we\'ll get the same spanning tree', answer_3: 'spanning will have less edges', answer_4: 'spanning will not cover all vertices', correct_answer: 'we\'ll get the same spanning tree' }
]
Question.create!(questions_3)

# Quiz 4
quiz_4 = Quiz.create!(user_id: 1, name: 'Human Anatomy', difficulty: 2)
questions_4 = [
  { quiz: quiz_4, name: 'What is the name of the system in the human body that transports blood?', answer_1: 'digestive', answer_2: 'cardiovascular', answer_3: 'lymphatic', answer_4: 'respiratory', correct_answer: 'cardiovascular' },
  { quiz: quiz_4, name: 'What hormone, produced in the pancreas, regulates blood sugar levels?', answer_1: 'insulin', answer_2: 'epinephrine', answer_3: 'prolactin', answer_4: 'oxytocin', correct_answer: 'insulin' },
  { quiz: quiz_4, name: 'Which is the largest gland in the human body?', answer_1: 'liver', answer_2: 'pancreas', answer_3: 'thyroid', answer_4: 'pineal gland', correct_answer: 'liver' },
  { quiz: quiz_4, name: 'Which of these hormones is produced by testes?', answer_1: 'adrenaline', answer_2: 'progesterone', answer_3: 'vasopressin', answer_4: 'testosterone', correct_answer: 'testosterone' },
  { quiz: quiz_4, name: 'Which muscle group covers the front and sides of the thigh?', answer_1: 'hamstring muscle', answer_2: 'adductor muscle', answer_3: 'vastus muscle', answer_4: 'quadriceps femoris muscle', correct_answer: 'quadriceps femoris muscle' },
  { quiz: quiz_4, name: 'Which of these is the principal muscle of respiration?', answer_1: 'diaphragm', answer_2: 'cilia', answer_3: 'flagella', answer_4: 'cardiac muscle', correct_answer: 'diaphragm' },
  { quiz: quiz_4, name: 'Which is the largest hollow space in a human body?', answer_1: 'pelvic cavity', answer_2: 'dorsal cavity', answer_3: 'ventral cavity', answer_4: 'abdominal cavity', correct_answer: 'abdominal cavity' },
  { quiz: quiz_4, name: 'Which is the largest joint in a human body?', answer_1: 'hip', answer_2: 'knee', answer_3: 'shoulder', answer_4: 'ankle', correct_answer: 'knee' },
  { quiz: quiz_4, name: 'What is the name of the tissue that connects muscle to bone?', answer_1: 'tendon', answer_2: 'epithelial', answer_3: 'ligament', answer_4: 'cartilage', correct_answer: 'tendon' },
  { quiz: quiz_4, name: 'Which is the largest nerve in the human body?', answer_1: 'trochlear nerve', answer_2: 'sciatic nerve', answer_3: 'vagus nerve', answer_4: 'phernic nerve', correct_answer: 'sciatic nerve' }
]
Question.create!(questions_4)

# Quiz 5
quiz_5 = Quiz.create!(user_id: 2, name: 'US Presidents', difficulty: 2)
questions_5 = [
  { quiz: quiz_5, name: 'The first American president to live in the White House was:', answer_1: 'Thomas Jefferson', answer_2: 'George Washington', answer_3: 'John Adams', answer_4: 'Abraham Lincoln', correct_answer: 'John Adams' },
  { quiz: quiz_5, name: 'What American president is associated with the Teddy Bear?', answer_1: 'Ted Kennedy', answer_2: 'Theodore Roosevelt', answer_3: 'Richard Nixon', answer_4: 'Abraham Lincoln', correct_answer: 'Theodore Roosevelt' },
  { quiz: quiz_5, name: 'Who was named president after Abraham Lincoln was assassinated?', answer_1: 'Ulysses S. Grant', answer_2: 'Grover Cleveland', answer_3: 'Theodore Roosevelt', answer_4: 'Andrew Johnson', correct_answer: 'Andrew Johnson' },
  { quiz: quiz_5, name: 'Which president signed the Louisiana Purchase?', answer_1: 'John Adams', answer_2: 'George Washington', answer_3: 'James K. Polk', answer_4: 'Thomas Jefferson', correct_answer: 'Thomas Jefferson' },
  { quiz: quiz_5, name: 'How many U.S. presidents have served more than two terms?', answer_1: '1', answer_2: '2', answer_3: '3', answer_4: '0', correct_answer: '1' },
  { quiz: quiz_5, name: 'Who was the first United States president to die in office?', answer_1: 'Chester A. Arthur', answer_2: 'Benjamin Harrison', answer_3: 'William Henry Harrison', answer_4: 'Ulysses S. Grant', correct_answer: 'William Henry Harrison' },
  { quiz: quiz_5, name: 'What was the name of the speech that Richard Nixon delivered on a nationally televised address?', answer_1: 'Infamy Speech', answer_2: 'Checkers Speech', answer_3: 'A House Divided', answer_4: 'I Have a Dream', correct_answer: 'Checkers Speech' },
  { quiz: quiz_5, name: 'What was President Donald Trump\'s campaign slogan in the 2016 presidential election?', answer_1: 'Yes We Can', answer_2: 'Make America Great Again', answer_3: 'A Stronger America', answer_4: 'Make America Strong Again', correct_answer: 'Make America Great Again' }
]
Question.create!(questions_5)
