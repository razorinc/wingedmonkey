class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_user
  before_filter :require_provider

  helper_method :current_provider

  def present(object, name)
    klass ||= Providerpresenters.const_get(current_provider.type.to_s.camelize).const_get(name.to_s.camelize + "Presenter")
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def require_provider
    if not current_provider
      redirect_to root_url
    else
      # shoving this into Providers allows objects throughout the app to access
      PROVIDERS.current_provider_key = session[:current_provider]
    end
  end

  def set_current_provider provider_name
    session[:current_provider] = provider_name
    PROVIDERS.current_provider_key = provider_name
  end

  def current_provider
    if session[:current_provider]
      if not PROVIDERS.current_provider_key
        PROVIDERS.current_provider_key = session[:current_provider]
      end
      provider = PROVIDERS.current_provider
      # if there's no provider matching the current key, clear the session
      session[:current_provider] = nil if not provider
      provider # return the provider (or nil)
    end
  end
end
