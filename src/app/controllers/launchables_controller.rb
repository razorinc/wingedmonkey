class LaunchablesController < ApplicationController
  before_filter :require_provider

  def list
    @launchables = current_provider.list_launchables
  end

  def launch
    redirect_to :controller => "dashboard", :action => "index"
  end

  def index
    @launchables = current_provider.list_launchables
  end

end
