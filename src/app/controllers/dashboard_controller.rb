class DashboardController < ApplicationController
  # before_filter :authenticate_user!
  before_filter :require_provider, except: :index

  def index
    if current_provider
      @launched_apps = current_provider.list_systems
    end
  end
end
