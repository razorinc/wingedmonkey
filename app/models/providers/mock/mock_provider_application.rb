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

module Providers
  module Mock
    class MockProviderApplication < ProviderApplication

      def available_actions
        case wm_state
        when ProviderApplication::WM_STATE_RUNNING then
          [ ProviderApplication::WM_ACTION_TERMINATE, ProviderApplication::WM_ACTION_PAUSE, ProviderApplication::WM_ACTION_STOP ]
        when ProviderApplication::WM_STATE_STOPPED then
          [ ProviderApplication::WM_ACTION_TERMINATE, ProviderApplication::WM_ACTION_START ]
        when ProviderApplication::WM_STATE_PAUSED then
          [ ProviderApplication::WM_ACTION_TERMINATE, ProviderApplication::WM_ACTION_START, ProviderApplication::WM_ACTION_STOP ]
        when ProviderApplication::WM_STATE_PENDING then
          []
        else
          [ ProviderApplication::WM_ACTION_TERMINATE ]
        end
      end

      def launch
        return false if not valid?
        @state = 'running'
        @wm_state = ProviderApplication::WM_STATE_RUNNING
        self.class.connect! do |connection|
          connection.add_application(self)
        end
      end

      def destroy
        self.class.connect! do |connection|
          connection.destroy_application(self)
        end
      end

      def start
        @state = 'running'
        @wm_state = ProviderApplication::WM_STATE_RUNNING
      end

      def pause
        @state = 'paused'
        @wm_state = ProviderApplication::WM_STATE_PAUSED
      end

      def stop
        @state = 'stopped'
        @wm_state = ProviderApplication::WM_STATE_STOPPED
      end

      def self.all filter=nil
        connect! {|connection| connection.applications}
      end

      def self.find id

        connect! do |connection|
          application = connection.applications.find{|app| app.id.to_s == id}
          raise ActiveRecord::RecordNotFound unless application
          application
        end
      end

      def as_json(options={})
        super(:root => false,
              :include => { :launchable => { :only => :name } })
      end
    end
  end
end
