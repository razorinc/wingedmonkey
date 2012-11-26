module Providers
  module Mock
    class MockProviderApplication < ProviderApplication
      @@provider_applications = []
      @@id = 0

      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
        @id = @@id
        @@id = @@id + 1
        @@provider_applications << self
      end

      def launchable
        Providers::Mock::MockLaunchable.find(@launchable_id)
      end

      # List all of the Provider Applications.
      def self.all filter=nil
        filter ||= {}
        @@provider_applications
      end
    end
  end
end
