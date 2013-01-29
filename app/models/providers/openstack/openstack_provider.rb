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

require 'openstack'

module Providers
  module OpenStack
    class OpenStackProvider < Provider
      attr_accessor :tenant

      def valid_credentials? credentials
        @credentials = credentials
        begin
          connect!
        rescue => e
          false
        end
      end

      def connect!
        ::OpenStack::Connection.
          create({
                   :username => @credentials[:username],
                   :api_key => @credentials[:password],
                   :auth_method => 'password',
                   :auth_url => url,
                   :authtenant_name => tenant
                 })
      end

      def flavors
        flavors = []
        connection = connect!
        flavors_hash = connection.flavors
        flavors_hash.each do |flavor_hash|
          flavors << connection.get_flavor(flavor_hash[:id])
        end
        flavors
      end
    end
  end
end
