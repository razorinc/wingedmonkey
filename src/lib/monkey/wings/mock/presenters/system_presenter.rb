module Monkey::Wings::Mock::Presenters
  class SystemPresenter < Monkey::Wings::BasePresenter
    presents :system

    def google
      h.link_to "Google", "http://www.google.com"
    end
  end
end
