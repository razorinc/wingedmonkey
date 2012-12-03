module Providers::Mock
  # The connection object for a mock provider
  # Meant to immitate a connection to a real provider's API
  # This should not be copied for other provider implementations
  require_relative 'mock_launchable'
  class MockConnection
    MOCK_LAUNCHABLE_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "mock", "launchables.yml"))
    def launchables
      MOCK_LAUNCHABLE_CONFIG
    end
  end
end
