class ProvidersController < ApplicationController
  skip_before_filter :require_provider, :only => :select

  def select
    set_current_provider params[:provider]
    render :nothing => true
  end
end
