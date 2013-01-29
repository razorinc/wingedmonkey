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
    class OvirtLaunchable < Launchable

      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        launchables = []
        connect! do |connection|
          connection.templates.map do |template|
            OvirtLaunchable.new(
              :id => template.id,
              :name => template.name,
              :description => template.description
            )
          end
        end
      end

      def self.find(id)
        self.all.find{|launchable| launchable.id.to_s == id.to_s}
      end
    end
  end
end
