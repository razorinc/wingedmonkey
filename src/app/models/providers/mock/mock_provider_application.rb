module Providers
  module Mock
    class MockProviderApplication < ProviderApplication
      def initialize config
        @config = config
        # create delegator methods to access configuration info
        # but, don't expose credentials
        @config.each.reject{|k,v| k == :credentials}.each do |k,v|
          self.class.send(:define_method, k, proc {@config[k]})
        end
      end

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
