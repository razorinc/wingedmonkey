object @provider_application

attributes :id, :launchable, :name, :state, :wm_state, :ips, :creation_time, :cores, :memory

node(:available_actions) { |app| app.available_actions }
