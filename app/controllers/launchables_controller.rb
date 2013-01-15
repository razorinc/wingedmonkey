class LaunchablesController < ApplicationController
  def index
    @launchables = Launchable.all.select {
      |launchable| launchable.wm_state == Launchable::WM_STATE_ACTIVE
    }
  end
end
