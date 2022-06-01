class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :login_attempts
  has_one_attached :user_image

  has_many :created_quizzes, class_name: 'Quiz'

  has_many :results, dependent: :destroy
  has_many :quizzes, through: :results, source: :quiz

  attr_accessor :probability
end
