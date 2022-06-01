class Result < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :user_answers

  enum status: { not_started: 0, started: 1, completed: 2 }
  
  def calculate_score
    score = 0
    quiz.questions.each do |question|
      user_answer = user_answers.find_by(question: question, user: user)
      score += 1 if question.correct_answer == user_answer&.given_answer
    end
    
    update!(score: score)
  end
end
