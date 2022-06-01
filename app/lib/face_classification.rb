require 'singleton'

class FaceClassification
  include Singleton

  def classify(image)
    image_path = preprocess_image(image)

    python_output = `python3 face_recognition/cnn_implementation_YALE/classify.py #{image_path}`
    user_classes = python_output.split("\n").map(&:split).to_h

    users = User.where(user_class: user_classes.keys)
    users.to_a.map! do |user|
      user.probability = user_classes[user.user_class]
    end

    users.sort_by{ |u| u.probability.chomp('%').to_f }.reverse
  end

  private
  def preprocess_image(image)
    image_path = ActiveStorage::Blob.service.path_for(image.key)
    `python3 face_recognition/cnn_implementation_YALE/data_processing.py #{image_path}`

    image_path + '.pgm'
  end

end