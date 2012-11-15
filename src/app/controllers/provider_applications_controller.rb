class ProviderApplicationsController < ApplicationController
  skip_before_filter :require_provider, :only => :index

  def index
    if current_provider
      @provider_applications = current_provider.list_systems
    end
  end

  def new
    if params[:launchable_id].present?
      @launchable = Launchable.find(params[:launchable_id])
      @provider_application = ProviderApplication.new
    else
      redirect_to launchables_path, :alert => "Please select Application Blueprint first"
    end
  end
end
