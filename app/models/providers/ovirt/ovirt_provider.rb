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

require 'rbovirt'

module Providers
  module Ovirt
    class OvirtProvider < Provider
      attr_accessor :domain, :datacenter

      def valid_credentials? credentials
        @credentials = credentials
        begin
          client = connect!
          client.api_version
        rescue => e
          false
        end
      end

      def connect!
        OVIRT::Client.new("#{@credentials[:username]}@#{domain}", @credentials[:password], url, datacenter)
      end
    end
  end
end
