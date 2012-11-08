class ProviderController < ApplicationController
  def select
    set_current_provider params[:provider]
  end
end
