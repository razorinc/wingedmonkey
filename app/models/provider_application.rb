# ProviderApplication tableless model

class ProviderApplication
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  extend ProviderModel

  define_model_callbacks :save
  before_save :valid?

  attr_accessor :id, :launchable_id, :name, :state, :wm_state

  validates :name, :presence => true
  validates :launchable_id, :presence => true

  WM_STATE_PENDING = "PENDING"
  WM_STATE_RUNNING = "RUNNING"
  WM_STATE_STOPPING = "STOPPING"
  WM_STATE_STOPPED = "STOPPED"
  WM_STATE_FAILED = "FAILED"

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save
    run_callbacks :save do
      new_record? ? launch : update
    end
  end

  ## not implemented yet
  def new_record?
    true
  end
end
