class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_provider_authentication

  helper_method :current_provider
  helper_method :current_provider_id

  rescue_from Exception, :with => :handle_error

  def require_provider_authentication
    session[:return_to] ||= request.path
    if current_provider.present? and session[:current_provider_creds].present?
      current_provider.credentials = session[:current_provider_creds]
      Provider.current = current_provider
    else
      redirect_to login_path
    end
  end

  def set_current_provider_id provider_id
    session[:current_provider_id] = provider_id
    session.delete(:current_provider_creds)
  end

  def current_provider_id
    session[:current_provider_id]
  end

  def current_provider
    Provider.find(session[:current_provider_id])
  end

  def handle_error(error)
    Rails.logger.send(:error, error.backtrace.join("\n\t"))
    flash.now[:error] = error
    render :template => "layouts/empty", :layout => "application", :status => 500
  end
end
