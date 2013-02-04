# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

require 'yaml'

class Provider
  #TODO add validation of the config file
  #PROVIDERS_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "providers.yml")) rescue []
  @@providers = nil

  #more to be added as needed
  attr_accessor :id, :name, :type, :url, :locale_id

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
