class FaceClassification
  def initialize(image)
    @image = image
  end
  def classify
    image_path = preprocess_image

    python_output = `python3 cnn_logic/classify.py #{image_path}`
    user_classes = python_output.split("\n").map(&:split).to_h

    users = User.where(user_class: user_classes.keys)
    users.to_a.map! do |user|
      user.probability = user_classes[user.user_class]
    end

    users.sort_by(&:probability).reverse
  end

  private
  def preprocess_image
    image_path = ActiveStorage::Blob.service.path_for(@image.key)
    `python3 cnn_logic/data_processing.py #{image_path}`

    image_path + '.pgm'
  end

end