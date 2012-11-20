module ProviderPresenters
  module Mock
    class LaunchablePresenter < BasePresenter
      presents :launchable

      def google
        h.link_to "Google", "http://www.google.com"
      end
    end
  end
end
