class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_user
  before_filter :require_provider

  helper_method :current_provider_key

  def present(object, name)
    klass ||= ProviderPresenters.const_get(current_provider.type.to_s.camelize).const_get(name.to_s.camelize + "Presenter")
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def require_provider
    if not current_provider_key
      redirect_to root_url
    # else
    #   # shoving this into Providers allows objects throughout the app to access
    #   PROVIDERS.current_provider_key = session[:current_provider]
    end
  end

  def set_current_provider provider_name
    session[:current_provider] = provider_name.to_sym
    # PROVIDERS.current_provider_key = provider_name
  end

  # returns given provider hash
  def current_provider
    Provider.new(current_provider_key)
    # if session[:current_provider]
    #   unless PROVIDERS.current_provider_key
    #     PROVIDERS.current_provider_key = session[:current_provider]
    #   end
    #   provider = PROVIDERS.current_provider
    #   # if there's no provider matching the current key, clear the session
    #   session[:current_provider] = nil unless provider
    #   provider # return the provider (or nil)
    # end
  end

  def current_provider_key
    session[:current_provider] unless session[:current_provider].blank?
  end

  def current_provider_model_class(model_name)
    provider_type = current_provider.type.capitalize
    Providers.const_get(provider_type).const_get(provider_type+model_name)
  end
end
