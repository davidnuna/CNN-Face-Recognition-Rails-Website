# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    super
    LoginAttempt.find(params[:user][:login_attempt_id]).update(status: :completed)
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
