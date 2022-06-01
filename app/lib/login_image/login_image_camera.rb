class LoginImage::LoginImageCamera < LoginImage::LoginImageBase
  def get_image
    base_64_image = @params[:login_image_camera].gsub!(/^data:.*,/, '')
    decoded_image = Base64.decode64(base_64_image)
    StringIO.new(decoded_image)
  end
end