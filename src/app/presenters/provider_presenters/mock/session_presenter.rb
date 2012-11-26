module ProviderPresenters
  module Mock
    class SessionPresenter < BasePresenter
      presents :session

      def login_form
        form = h.label_tag "Username"
        form += h.text_field_tag "username"
      end
    end
  end
end
