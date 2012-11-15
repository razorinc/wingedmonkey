module Monkey::Wings
  class Mock
    def initialize config
      @config = config
      # create delegator methods to access configuration info
      # but, don't expose credentials
      @config.each.reject{|k,v| k == :credentials}.each do |k,v|
        self.class.send(:define_method, k, proc {@config[k]})
      end
    end

    # Launch the launchable item.
    # The associated launch parameters are provided in the params object.
    def launch launchable, params

    end

    # Retrieve a specific launchable item.
    # Permission check should be applied to ensure that the user can actually
    # see the requested id.
    def launchable id

    end

    # List all of the launchable items.
    # The list may be reduced by the information in the current context.
    # For instance, the current user, the user's permissions, etc...
    def list_launchables filter=nil
      filter ||= {}
      {}
    end

    # List all of the systems.
    # The list may be reduced by the information in the current context.
    # For instance, the current user, the user's permission, etc...
    def list_systems filter=nil
      filter ||= {}
      {}
    end
  end
end
