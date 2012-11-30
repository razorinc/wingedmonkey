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

  def connect credenials
    raise "Base provider does not implement #connect method.  Check that config/providers.yml uses provider-specific objects instead of directly using Provider."
  end

private
  def self.providers
    if not @@providers or @@providers.empty?
      require 'providers'
      @@providers = YAML.load_file(File.join("#{Rails.root}", "config", "providers.yml"))
    end
    @@providers
  end
end
