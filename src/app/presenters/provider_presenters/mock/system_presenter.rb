module ProviderPresenters
  module Mock
    class SystemPresenter < BasePresenter
      presents :system

      def google
        h.link_to "Google", "http://www.google.com"
      end
    end
  end
end
