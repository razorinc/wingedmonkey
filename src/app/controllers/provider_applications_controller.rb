class ProviderApplicationsController < ApplicationController
  skip_before_filter :require_provider, :only => :index

  def index
    if current_provider
      @provider_applications = current_provider.list_systems
    end
  end
end
