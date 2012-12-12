module ProviderModel
  def connect!
    connection = Provider.current.connect!
    if block_given?
      yield connection
    else
      return connection
    end
  end

  def provider_model
    provider_type = Provider.current.type.camelize
    model_name = self.name
    Providers.const_get(provider_type).const_get(provider_type+model_name)
  end

  def all
    provider_model.all
  end

  def find id
    provider_model.find id
  end

  def create attributes
    provider_model.new attributes
  end
end
