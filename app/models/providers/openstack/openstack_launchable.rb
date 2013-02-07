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
    class OpenStackLaunchable < Launchable
      attr_accessor :state

      def attributes
        super.merge({ 'state' => state })
      end

      def self.all filter=nil
        launchables = []
        connect! {|connection|
          images_hash = connection.images
          images_hash.each do |image_hash|
            state = image_hash[:status]
            wm_state = (state == "ACTIVE") ? Launchable::WM_STATE_ACTIVE : Launchable::WM_STATE_INACTIVE
            launchables << Launchable.
              create({ :id => image_hash[:id],
                       :name => image_hash[:name],
                       :state => state,
                       :wm_state => wm_state
                     })
          end
        }
        launchables
      end

      def self.find(id)
        self.all.find{|image| image.id.to_s == id}
      end
    end
  end
end
