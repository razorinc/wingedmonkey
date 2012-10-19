# load the settings.yaml file and make it available to the app
require 'ostruct'
require 'yaml'

settings_file = File.join("#{Rails.root}", "config", "settings.yaml")
settings = YAML.load_file(settings_file) rescue {}

Settings = OpenStruct.new(settings)
Providers = OpenStruct.new(settings[:providers])

Providers.defaults[:rhev] ||= {}
Providers.defaults[:rhev][:credenials] ||= {}
