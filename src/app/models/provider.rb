require 'yaml'

class Provider
  #TODO rescue empty providers config properly, add validation of the config file
  PROVIDERS_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "providers.yml")) rescue {}

  #more to be added as needed
  attr_accessor :key, :name, :type, :url

  def self.all
    PROVIDERS_CONFIG
  end

  def self.find(key)
    PROVIDERS_CONFIG.find{ |provider| provider.key == key }
  end
end
