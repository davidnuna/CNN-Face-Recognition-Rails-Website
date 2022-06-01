class Question < ApplicationRecord
  belongs_to :quiz

  has_many :user_answers

  def user_answer(user)
    user_answers.find_by(user: user)&.given_answer
  end
end
