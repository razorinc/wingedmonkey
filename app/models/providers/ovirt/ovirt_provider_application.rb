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
  module Ovirt
    class OvirtProviderApplication < ProviderApplication
      attr_accessor :ips, :creation_time, :cores, :memory
      validates_numericality_of :cores

      def attributes
        super.merge({ 'ips' => ips,
                      'creation_time' => creation_time,
                      'memory' => memory,
                      'cores' => cores })
      end

      def available_actions
        case wm_state
        when ProviderApplication::WM_STATE_RUNNING then
          [ ProviderApplication::WM_ACTION_PAUSE, ProviderApplication::WM_ACTION_STOP ]
        when ProviderApplication::WM_STATE_STOPPED then
          [ ProviderApplication::WM_ACTION_TERMINATE, ProviderApplication::WM_ACTION_START ]
        when ProviderApplication::WM_STATE_PAUSED then
          [ ProviderApplication::WM_ACTION_START, ProviderApplication::WM_ACTION_STOP ]
        when ProviderApplication::WM_STATE_PENDING then
          []
        else
          [ ProviderApplication::WM_ACTION_TERMINATE ]
        end
      end

      def launch
        self.class.connect! do |client|
          vm = client.create_vm(:name => name,
                                :template => launchable.id,
                                :cores => cores
                                )
          self.id = vm.id
        end
      end

      def destroy
        self.class.connect! do |client|
          client.destroy_vm id
        end
      end

      def start
        self.class.connect! do |client|
          client.vm_action(id, :start)
        end
      end

      def pause
        self.class.connect! do |client|
          client.vm_action(id, :suspend)
        end
      end

      def stop
        self.class.connect! do |client|
          client.vm_action(id, :shutdown)
        end
      end

      def self.all filter=nil
        templates = Launchable.all
        connect! do |client|
          client.vms.map do |vm|
            self.map_vm_to_application(vm, templates)
          end
        end
      end

      def self.find id
        templates = Launchable.all
        connect! do |client|
          vm = client.vm(id)
          self.map_vm_to_application(vm, templates)
        end
      end

      def as_json(options={})
        super(:root => false)
      end

      private

      def self.map_vm_to_application(vm, templates)
        template_id = vm.template.id
        state = vm.status.strip
        wm_state = case state
                   when "image_locked", "powering_up", "saving_state", "restoring_state", "powering_down" then ProviderApplication::WM_STATE_PENDING
                   when "up" then ProviderApplication::WM_STATE_RUNNING
                   when "down" then ProviderApplication::WM_STATE_STOPPED
                   when "suspended" then ProviderApplication::WM_STATE_PAUSED
                   else ProviderApplication::WM_STATE_FAILED
                   end

        ProviderApplication.create({
                                     :id => vm.id,
                                     :launchable => templates.find{|t| t.id.to_s == template_id},
                                     :name => vm.name,
                                     :state => state,
                                     :wm_state => wm_state,
                                     :ips => vm.ips,
                                     :creation_time => vm.creation_time,
                                     :memory => vm.memory.strip,
                                     :cores => vm.cores
                                   })
      end
    end
  end
end
