class DashboardController < ApplicationController
  def index
    ovirt = MonkeyWings::Ovirt.new
    @launched_apps = ovirt.client.vms
  end
end
