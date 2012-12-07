module Providers::Mock
  # The connection object for a mock provider
  # Meant to immitate a connection to a real provider's API
  # This should not be copied for other provider implementations
  require_relative 'mock_launchable'
  class MockConnection
    @@provider_applications = []
    @@id = 1


    MOCK_LAUNCHABLE_CONFIG = YAML.load_file(File.join("#{Rails.root}", "config", "mock", "launchables.yml"))
    def launchables
      MOCK_LAUNCHABLE_CONFIG
    end

    def applications
      @@provider_applications
    end

    def add_application(application)
      application.id = @@id
      @@id += 1
      @@provider_applications << application
    end

    def destroy_application(application)
      @@provider_applications.delete(application)
    end
  end
end
