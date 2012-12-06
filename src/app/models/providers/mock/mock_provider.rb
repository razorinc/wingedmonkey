module Providers
  module Mock
    class MockProvider < Provider
      def valid_credentials? credentials
        true
      end

      def connect!
        raise "Invalid credentials" if not @credentials #TODO: code smell
        MockConnection.new
      end
    end
  end
end
