# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

class ProviderApplicationsController < ApplicationController
  def index
    @provider_applications = ProviderApplication.all

    respond_to do |format|
      format.html
      format.js
      format.json{ render json: @provider_applications }
    end
  end

  def new
    if params[:launchable_id].present?
      @launchable = Launchable.find(params[:launchable_id])
      @provider_application = ProviderApplication.create({:launchable => @launchable})
    else
      flash[:error] = _("Please select a Launchable first")
      redirect_to launchables_path
    end
  end

  def create
    @launchable = Launchable.find(params[:launchable_id])
    params[:provider_application][:launchable] = @launchable
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

    flash[:notice] = _("The provider application '%s' is being stopped.  You may need to reload this page to see the change take effect.") % @provider_application.name
    redirect_to provider_applications_path
  end
end
