class LoginImage::LoginImageUploaded < LoginImage::LoginImageBase
  def get_image
    @params[:login_image_uploaded]
  end
end
