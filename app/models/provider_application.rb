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

# ProviderApplication tableless model

class ProviderApplication
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  extend ProviderModel

  define_model_callbacks :save
  before_save :valid?

  attr_accessor :id, :launchable, :name, :state, :wm_state

  validates :name, :presence => true
  validates :launchable, :presence => true

  WM_STATE_PENDING = "PENDING"
  WM_STATE_RUNNING = "RUNNING"
  WM_STATE_STOPPING = "STOPPING"
  WM_STATE_STOPPED = "STOPPED"
  WM_STATE_FAILED = "FAILED"

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save
    run_callbacks :save do
      new_record? ? launch : update
    end
  end

  ## not implemented yet
  def new_record?
    true
  end
end
