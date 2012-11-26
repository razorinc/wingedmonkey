class ProviderApplicationsController < ApplicationController
  skip_before_filter :require_provider, :only => :index

  def index
    # TODO in future, user will be redirected to provider login page instead of here if there is no current_provider
    # then the check for current_provider as well as skip_before_filter call will not be necessary
    if current_provider.present?
      @provider_applications = current_provider_model_class(:provider_application).all
    end
  end

  def new
    if params[:launchable_id].present?
      @launchable = current_provider_model_class(:launchable).find(params[:launchable_id])
    else
      redirect_to launchables_path, :alert => "Please select Application Blueprint first"
    end
  end

  def create
    current_provider_model_class(:launchable).launch(params[:launchable_id], params[:name])
    redirect_to provider_applications_path
  end
end
