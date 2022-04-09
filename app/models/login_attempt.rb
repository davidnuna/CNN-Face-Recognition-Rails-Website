class LoginAttempt < ApplicationRecord
  enum status: { image_uploaded: 0, user_selected: 1, completed: 2 }

  belongs_to :user, optional: true

  has_one_attached :login_image, dependent: :destroy
end
