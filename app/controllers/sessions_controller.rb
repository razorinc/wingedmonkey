class SessionsController < ApplicationController
  layout "login"
  skip_before_filter :require_provider_authentication

  def new
  end

  def create
    if current_provider.valid_credentials?(params)
      session[:current_provider_creds] = params
      return_to = session.delete(:return_to) || root_url
      redirect_to return_to
    else
      flash[:error] = "Invalid cloud credentials"
      render "new"
    end
  end

  def destroy
    session.delete(:current_provider_creds)
    session.delete(:current_provider_id)
    redirect_to login_path
  end
end
