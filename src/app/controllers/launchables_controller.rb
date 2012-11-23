class LaunchablesController < ApplicationController
  def index
    @launchables = current_provider_model_class(:launchable).all
  end
end
