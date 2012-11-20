module ApplicationHelper
  def present(object, name)
    klass = presenter_class(name)
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  private
  # Finds the class at:
  #   ProviderPresenters::<Provider>::<Name>Presenter
  def presenter_class name
    provider_name = current_provider.type.to_s.camelize
    class_name = name.to_s.camelize + "Presenter"
    provider_module = ProviderPresenters.const_get(provider_name)
    provider_module.const_get(class_name)
  end
end
