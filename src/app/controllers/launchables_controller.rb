class LaunchablesController < ApplicationController
  def index
    @launchables = current_provider_model_class("Launchable").all
  end
end
