module Providers
  module Mock
    class MockProvider < Provider
      def connect credentials
        true
      end
    end
  end
end
