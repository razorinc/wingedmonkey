require 'rbovirt'

module Providers
  module Ovirt

    class OvirtProvider < Provider
      attr_accessor :datacenter

      def valid_credentials? credentials
        @credentials = credentials
        client = connect!
        begin
          client.api_version
        rescue => e
          false
        end
        true
      end

      def connect!
        OVIRT::Client.new(@credentials[:username], @credentials[:password], url, datacenter)
      end
    end
  end
end
