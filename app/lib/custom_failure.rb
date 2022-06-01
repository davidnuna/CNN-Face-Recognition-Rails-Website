class CustomFailure < Devise::FailureApp
  def redirect_url
    params[:user][:login_attempt_id].present? ? Rails.application.routes.url_helpers.login_page_login_path(params[:user][:login_attempt_id]) : Rails.application.routes.url_helpers.user_session_path
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end