module Providers
  module Mock
    class MockProvider < Provider
      def valid_credentials? credentials
        true
      end

      def connect! credentials
        true
      end
    end
  end
end
