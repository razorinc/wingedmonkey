# load the settings.yml file and make it available to the app
require 'yaml'

settings_file = File.join("#{Rails.root}", "config", "settings.yml")
Settings = YAML.load_file(settings_file) rescue {}

class ProviderCollection
  def initialize providers
    @providers = providers
  end

  def current_provider
    provider_config = @providers[self.current_provider_key]
    provider_class.new(provider_config)
  end

  def current_provider_key
    Thread.current[:current_provider_key]
  end

  def current_provider_key= provider_key
    Thread.current[:current_provider_key] = provider_key.to_sym
  end

  def list
    @providers.reject{|k,v| k == :defaults}.map do |key,provider|
      [provider[:name], key]
    end
  end

  private
  def provider_class
    classname = @providers[current_provider_key][:type].capitalize
    Monkey::Wings.const_get(classname)
  end
end

Providers = ProviderCollection.new(Settings[:providers])
