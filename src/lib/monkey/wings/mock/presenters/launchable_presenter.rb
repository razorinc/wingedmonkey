module Monkey::Wings::Mock::Presenters
  class LaunchablePresenter < Monkey::Wings::BasePresenter
    presents :launchable

    def google
      h.link_to "Google", "http://www.google.com"
    end
  end
end
