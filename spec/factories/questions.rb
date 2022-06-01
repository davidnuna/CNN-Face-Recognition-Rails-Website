FactoryBot.define do
  factory :question_1, class: Question do
    name { 'Question 1?' }
    answer_1 { 'Question 1 Answer 1'}
    answer_2 { 'Question 1 Answer 2'}
    answer_3 { 'Question 1 Answer 3'}
    answer_4 { 'Question 1 Answer 4'}
    correct_answer { 'Question 1 Answer 2'}
  end
  
  factory :question_2, class: Question do
    name { 'Question 2?' }
    answer_1 { 'Question 2 Answer 1'}
    answer_2 { 'Question 2 Answer 2'}
    answer_3 { 'Question 2 Answer 3'}
    answer_4 { 'Question 2 Answer 4'}
    correct_answer { 'Question 2 Answer 4'}
  end
end