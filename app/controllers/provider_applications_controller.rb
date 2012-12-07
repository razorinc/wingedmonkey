class ProviderApplicationsController < ApplicationController
  def index
    @provider_applications = ProviderApplication.all
  end

  def new
    if params[:launchable_id].present?
      @launchable = Launchable.find(params[:launchable_id])
      @provider_application = ProviderApplication.create({:launchable_id => @launchable.id})
    else
      redirect_to launchables_path, :alert => "Please select Application Blueprint first"
    end
  end

  def create
    @provider_application = ProviderApplication.create(params[:provider_application])
    if @provider_application.save
      redirect_to provider_applications_path
    else
      render :new
    end
  end

  def destroy
    @provider_application = params[:id] ? ProviderApplication.find(params[:id]) : nil
    if !@provider_application.nil?
      @provider_application.destroy
    end

    redirect_to provider_applications_path
  end
end
