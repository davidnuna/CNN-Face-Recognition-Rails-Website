class Quiz < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :created_by, class_name: 'User', foreign_key: :user_id
  
  has_many :questions, dependent: :destroy

  has_many :results, dependent: :destroy
  has_many :participants, through: :results, source: :user

  enum difficulty: { easy: 0, medium: 1, hard: 2 }

  def user_status(user)
    results.find_by(user: user)&.status || 'not_started'
  end
  
  def user_score(user)
    results.find_by(user: user)&.score || 0
  end

  def user_completed(user)
    user_status(user) == 'completed'
  end
end
