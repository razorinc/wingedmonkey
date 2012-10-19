class LaunchController < ApplicationController
  def list
    ovirt = MonkeyWings::Ovirt.new
    @blueprints = ovirt.client.templates
  end

  def launch
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
