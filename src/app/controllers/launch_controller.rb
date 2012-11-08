class LaunchController < ApplicationController
  before_filter :require_provider

  def list
    @blueprints = current_provider.list_launchables
  end

  def launch
    redirect_to :controller => "dashboard", :action => "index"
  end

  def start
  end

  def stop
  end

  def pause
  end

  def resume
  end

  def restart
  end

  def snapshot
  end

  def clone
  end
end
