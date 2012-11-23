class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_user
  before_filter :require_provider

  helper_method :current_provider
  helper_method :current_provider_id

  def present(object, name)
    klass ||= ProviderPresenters.const_get(current_provider.type.to_s.camelize).const_get(name.to_s.camelize + "Presenter")
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def require_provider
    redirect_to root_url unless current_provider.present?
  end

  def set_current_provider_id provider_id
    session[:current_provider_id] = provider_id
  end

  def current_provider_id
    session[:current_provider_id]
  end

  def current_provider
    Provider.find(session[:current_provider_id])
  end

  def current_provider_model_class(model_name)
    provider_type = current_provider.type.capitalize
    model_name = model_name.to_s.camelize
    Providers.const_get(provider_type).const_get(provider_type+model_name)
  end
end
