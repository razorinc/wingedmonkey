object @provider_application

attributes :id, :launchable, :name, :state, :wm_state, :ips, :creation_time, :cores, :memory

node(:available_actions) { |app| app.available_actions }
node :toggles do
  { :show_properties => false, :show_delete => false }
end

node(:uptime) { |app| time_ago_in_words(app.creation_time) }
node(:humanized_memory) { |app| number_to_human_size(app.memory) }
