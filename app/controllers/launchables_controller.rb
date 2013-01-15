class LaunchablesController < ApplicationController
  def index
    @launchables = Launchable.all.select {
      |launchable| launchable.wm_state == "ACTIVE"
    }
  end
end
