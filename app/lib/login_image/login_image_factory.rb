class LoginImage::LoginImageFactory
  def initialize(params)
    @params = params
  end

  def login_image
    login_image_params = @params.require(:login_attempt).permit(:login_image_method, :login_image_uploaded, :login_image_camera)

    case login_image_params[:login_image_method]
      when 'uploaded' then [LoginImage::LoginImageUploaded.new(login_image_params).get_image, login_image_params[:login_image_method]]
      when 'camera' then [LoginImage::LoginImageCamera.new(login_image_params).get_image, login_image_params[:login_image_method]]
      else
        raise StandardError
    end
  end
end