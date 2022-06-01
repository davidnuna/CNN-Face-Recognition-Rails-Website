# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/login
  def new
    render :standard_login
  end

  # POST /resource/sign_in
  def create
    if params[:user][:login_attempt_id].nil?
      user = User.find_by(email: params[:user][:email])
      redirect_to user_session_path, alert: 'Only teachers can authenticate through this form!' if user.present? && !user.admin?

      return if performed?
    end

    super
    LoginAttempt.find(params[:user][:login_attempt_id]).update(status: :completed) if params[:user][:login_attempt_id].present?
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login_attempt_id])
  end
end
