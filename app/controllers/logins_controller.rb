class LoginsController < ApplicationController
  before_action :load_login_attempt, only: [:select_user, :choose_user, :login_page]
  
  def index
    @logins = LoginAttempt.order("created_at DESC").where(user_id: current_user.id).paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @login_attempt = LoginAttempt.new
  end

  # Add validations and stuff (flashes)
  def create
    if params[:login_attempt][:login_image_uploaded].blank? && params[:login_attempt][:login_image_camera].blank?
      redirect_to new_login_path, alert: 'No photo has been captured/uploaded!'
      return
    end

    @login_attempt = LoginAttempt.create!
    login_image, login_method = LoginImage::LoginImageFactory.new(params).login_image

    login_method == 'camera' ? @login_attempt.login_image.attach(io: login_image, filename: 'login_image.jpeg') : @login_attempt.login_image.attach(login_image)
    if @login_attempt.login_image.attached? && @login_attempt.save
      redirect_to select_user_login_path(@login_attempt)
    else
      render json: 'ERROR'
    end
  end
  
  def select_user
    @users = FaceClassification.instance.classify(@login_attempt.login_image)
  end
  
  def choose_user
    if params[:user_id].blank?
      redirect_to select_user_login_path(@login_attempt), alert: 'No user has been selected!'
      return
    end

    @login_attempt.update!(user_id: params[:user_id], status: :user_selected)
    redirect_to login_page_login_path(@login_attempt)
  end
  
  def login_page
    @user = @login_attempt.user
  end
  
  private
  def load_login_attempt
    @login_attempt = LoginAttempt.find(params[:id])
  end
end
