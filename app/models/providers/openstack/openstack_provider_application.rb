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
  module OpenStack
    class OpenStackProviderApplication < ProviderApplication
      attr_accessor :flavor_id, :ip_addresses, :created_at

      def attributes
        super.merge({ 'flavor_id' => flavor_id,
                      'ip_addresses' => ip_addresses,
                      'created_at' => created_at })
      end

      def flavor
        self.class.connect! {|connection|
          connection.get_flavor(@flavor_id)
        }
      end

      def launch
        self.class.connect! {|connection|
          server = connection.create_server(:name => @name,
                                            :imageRef => @launchable.id,
                                            :flavorRef => @flavor_id)
          @id = server.id
        }
      end

      def destroy
        self.class.connect! {|connection|
          server = connection.get_server(@id)
          server.delete!
        }
      end

      def self.all filter=nil
        apps = []
        images = Launchable.all
        connect! {|connection|
          servers_hash = connection.list_servers_detail
          servers_hash.each do |server_hash|
            image_id = server_hash[:image][:id]
            state = server_hash[:status]
            wm_state = case state
                         when "BUILD", "HARD_REBOOT", "PASSWORD", "REBOOT", "REBUILD", "RESCUE", "RESIZE", "REVERT_RESIZE", "VERIFY_RESIZE" then ProviderApplication::WM_STATE_PENDING
                         when "ACTIVE" then ProviderApplication::WM_STATE_RUNNING
                         when "SHUTOFF", "SUSPENDED" then ProviderApplication::WM_STATE_STOPPED
                         else ProviderApplication::WM_STATE_FAILED
                       end
            apps << ProviderApplication.
              create({ :id => server_hash[:id],
                       :name => server_hash[:name],
                       :state => state,
                       :wm_state => wm_state,
                       :launchable => images.find{|image| image.id.to_s == image_id},
                       :flavor_id => server_hash[:flavor][:id],
                       :ip_addresses => server_hash[:addresses][:public].map{|x| x[:addr]} + server_hash[:addresses][:private].map{|x| x[:addr]},
                       :created_at => DateTime.parse(server_hash[:created])
                     })
          end
        }
        apps
      end

      def self.find id
        application = self.all.find{|app| app.id.to_s == id}
        raise ActiveRecord::RecordNotFound unless application
        application
      end

      def as_json(options={})
        super(:root => false,
              :include => { :launchable => { :only => :name },
                            :flavor => { :methods => :name_with_description } })
      end
    end
  end
end
