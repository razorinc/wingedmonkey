class LaunchablesController < ApplicationController
  def index
    @launchables = current_provider.list_launchables
  end
end
