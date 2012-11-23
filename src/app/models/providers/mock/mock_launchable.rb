module Providers
  module Mock
    class MockLaunchable < Launchable
      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        filter ||= {}
        {}
      end
    end
  end
end
