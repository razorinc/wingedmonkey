# load the settings.yml file and make it available to the app
require 'yaml'

settings_file = File.join("#{Rails.root}", "config", "settings.yml")
SETTINGS = YAML.load_file(settings_file) rescue {}

# PROVIDERS = ProviderCollection.new(SETTINGS[:providers])
