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
    class ConductorProvider < Provider
      attr_accessor :pool_id

      def valid_credentials? credentials
        @credentials = credentials
        client = connect!
        client.valid_credentials?
      end

      def connect!
        Providers::Conductor::ConductorClient.
          new(@credentials[:username], @credentials[:password], url, pool_id)
      end
    end
  end
end
