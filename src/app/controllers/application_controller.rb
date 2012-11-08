class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_provider

  def require_provider
    if not current_provider
      redirect_to dashboard_index_url
    else
      # shoving this into Providers allows objects throughout the app to access
      Providers.current_provider_key = session[:current_provider]
    end
  end

  def set_current_provider provider_name
    session[:current_provider] = provider_name
    Providers.current_provider_key = provider_name
  end

  def current_provider
    if session[:current_provider]
      if not Providers.current_provider_key
        Providers.current_provider_key = session[:current_provider]
      end
      Providers.current_provider
    end
  end
end
