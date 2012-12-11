class ProviderApplicationsController < ApplicationController
  def index
    @provider_applications = ProviderApplication.all
  end

  def new
    if params[:launchable_id].present?
      @provider = current_provider
      @launchable = Launchable.find(params[:launchable_id])
      @provider_application = ProviderApplication.create({:launchable_id => @launchable.id})
    else
      redirect_to launchables_path, :alert => "Please select Application Blueprint first"
    end
  end

  def create
    @provider_application = ProviderApplication.create(params[:provider_application])
    if @provider_application.save
      redirect_to launch_summary_provider_application_path(@provider_application.id)
    else
      render :new
    end
  end

  def show
    @provider_application = ProviderApplication.find(params[:id])
  end

  def launch_summary
    @provider_application = ProviderApplication.find(params[:id])
  end

  def destroy
    @provider_application = params[:id] ? ProviderApplication.find(params[:id]) : nil
    if !@provider_application.nil?
      @provider_application.destroy
    end

    redirect_to provider_applications_path
  end
end
