# Copyright 2012-2013 Red Hat
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
  module Conductor
    class ConductorProviderApplication < ProviderApplication
      def launchable
        raise _("Conductor does not currently support the association between provider applications and launchables.")
      end

      def launch
        ## not implemented yet
      end

      def destroy
        ## not implemented yet
      end

      def self.all filter=nil
        connect! {|connection| connection.deployments}
      end

      def self.find id
        connect! do |connection|
          connection.deployments.find{|app| app.id.to_s == id}
        end
      end
    end
  end
end
