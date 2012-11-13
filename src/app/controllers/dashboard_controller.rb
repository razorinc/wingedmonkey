class DashboardController < ApplicationController
  skip_before_filter :require_provider, :only => :index

  def index
    if current_provider
      @launched_apps = current_provider.list_systems
    end
  end
end
