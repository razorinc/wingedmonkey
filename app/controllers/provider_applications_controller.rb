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
  before_filter :find_provider_application, :only => [:show, :launch_summary, :destroy, :stop, :start, :pause]
  def index

    respond_to do |format|
      format.html
      format.json{ render :json => ProviderApplication.all }
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
  end

  def launch_summary
  end

  def destroy
    @provider_application.destroy

    respond_to do |format|
      format.json{ render :json => @provider_application }
    end
  end

  def start
    if @provider_application.respond_to?("start")
      @provider_application.start
      @provider_application.wm_state = ProviderApplication::WM_STATE_PENDING
    else
      flash[:error] = _("'Start' action not supported by this provider.")
    end

    respond_to do |format|
      format.json{ render :json => @provider_application }
    end
  end

  def stop
    if @provider_application.respond_to?("stop")
      @provider_application.stop
    else
      flash[:error] = _("'Stop' action not supported by this provider.")
    end

    respond_to do |format|
      format.json{ render :json => @provider_application }
    end
  end

  def pause
    if @provider_application.respond_to?("pause")
      @provider_application.pause
      @provider_application.wm_state = ProviderApplication::WM_STATE_PENDING
    else
      flash[:error] = _("'Pause' action not supported by this provider.")
    end

    respond_to do |format|
      format.json{ render :json => @provider_application }
    end
  end

  private

  def find_provider_application
    @provider_application = ProviderApplication.find(params[:id])
  end
end
