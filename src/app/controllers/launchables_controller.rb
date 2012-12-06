class LaunchablesController < ApplicationController
  def index
    @launchables = Launchable.all
  end
end
