module Providers
  module Mock
    class MockProviderApplication < ProviderApplication
      # List all of the Provider Applications.
      def self.all filter=nil
        filter ||= {}
        {}
      end
    end
  end
end
