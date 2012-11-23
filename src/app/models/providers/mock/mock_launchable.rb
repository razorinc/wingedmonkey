module Providers
  module Mock
    class MockLaunchable < Launchable
      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      # For instance, the current user, the user's permissions, etc...
      def self.all filter=nil
        filter ||= {}
        {}
      end
    end
  end
end
