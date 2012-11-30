class ProviderApplicationsController < ApplicationController
  def index
    @provider_applications = current_provider_model_class(:provider_application).all
  end

  def new
    if params[:launchable_id].present?
      @launchable = current_provider_model_class(:launchable).find(params[:launchable_id])
      @provider_application =
        current_provider_model_class(:provider_application).new({:launchable_id => @launchable.id})
    else
      redirect_to launchables_path, :alert => "Please select Application Blueprint first"
    end
  end

  def create
    @provider_application =
      current_provider_model_class(:provider_application).new(params[:provider_application])
    if @provider_application.save
      redirect_to provider_applications_path
    else
      render :new
    end
  end

  def destroy
    @provider_application =
      params[:id] ? current_provider_model_class(:provider_application).find(params[:id]) : nil

    if !@provider_application.nil?
      @provider_application.destroy
    end

    redirect_to provider_applications_path
  end
end
