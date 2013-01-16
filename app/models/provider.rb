require 'yaml'

class Provider
  #TODO add validation of the config file
  #PROVIDERS_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "providers.yml")) rescue []
  @@providers = nil

  #more to be added as needed
  attr_accessor :id, :name, :type, :url

  def self.all
    providers
  end

  def self.find(id)
    providers.find{ |provider| provider.id == id }
  end

  def valid_credentials? credentials
    not_implement __method__
  end

  def connect!
    not_implemented __method__
  end

  def credentials= credentials
    @credentials = credentials
  end

private
  def not_implemented method
    raise "Base provider does not implement ##{method} method.  Check that config/providers.yml uses provider-specific objects instead of directly using Provider."
  end

  def self.providers
    if not @@providers or @@providers.empty?
      require 'providers'
      @@providers = YAML.load_file(Rails.configuration.providers_file)
    end
    @@providers
  end

  def self.current
    Thread.current[:provider]
  end

  def self.current=(provider)
    Thread.current[:provider] = provider
  end
end
