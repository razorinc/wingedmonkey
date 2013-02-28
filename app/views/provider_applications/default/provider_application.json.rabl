object @provider_application

attributes :id, :launchable, :name, :state, :wm_state

node(:available_actions) { |app| app.available_actions }
node :toggles do
  { :show_properties => false, :show_delete => false }
end
