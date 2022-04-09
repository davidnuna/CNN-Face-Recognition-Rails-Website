class LoginsController < ApplicationController

  before_action :load_login_attempt, only: [:select_user, :choose_user, :login_page]

  def show
  end
  
  def index
  end
  
  def new
    @login_attempt = LoginAttempt.new
  end

  # Add validations and stuff (flashes)
  def create
    @params = params.required(:login_attempt).permit(:login_image)
    @login_attempt = LoginAttempt.new(@params)

    if @login_attempt.login_image.attached? && @login_attempt.save
      redirect_to select_user_login_path(@login_attempt)
    else
      render json: 'ERROR'
    end
  end
  
  def select_user
    @users = FaceClassification.new(@login_attempt.login_image).classify
  end
  
  def choose_user
    operation_succeeded = @login_attempt.update(user_id: params[:user_id], status: :user_selected)
    
    if operation_succeeded
      redirect_to login_page_login_path(@login_attempt)
    else
      render json: 'ERROR'
    end
  end
  
  def login_page
    @user = @login_attempt.user
  end
  
  private
  def load_login_attempt
    @login_attempt = LoginAttempt.find(params[:id])
  end
end
