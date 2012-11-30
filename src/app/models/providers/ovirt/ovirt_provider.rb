require 'rbovirt'

module Providers
  module Ovirt

    class OvirtProvider < Provider
      attr_accessor :datacenter

      def connect credentials
        client = OVIRT::Client.new(credentials[:username], credentials[:password], url, datacenter)
        begin
          client.api_version
        rescue => e
          false
        end
        true
      end
    end
  end
end
