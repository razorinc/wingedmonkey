require 'yaml'

class Provider
  #TODO add validation of the config file
  PROVIDERS_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "providers.yml")) rescue []

  #more to be added as needed
  attr_accessor :id, :name, :type, :url

  def self.all
    PROVIDERS_CONFIG
  end

  def self.find(id)
    PROVIDERS_CONFIG.find{ |provider| provider.id == id }
  end
end
