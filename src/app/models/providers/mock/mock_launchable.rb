module Providers
  module Mock
    class MockLaunchable < Launchable
      MOCK_LAUNCHABLE_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "mock", "launchables.yml"))

      # List all of the launchable items.
      # The list may be reduced by the information in the current context.
      def self.all filter=nil
        filter ||= {}
        MOCK_LAUNCHABLE_CONFIG
      end

      def self.find(id)
        MOCK_LAUNCHABLE_CONFIG.find{ |launchable| launchable.id.to_s == id }
      end

      def self.launch(id, name)
        launchable = find(id)
        app = MockProviderApplication.new({
                                            :launchable_id => id,
                                            :name => name,
                                            :state => 'running'
                                          })
      end
    end
  end
end
