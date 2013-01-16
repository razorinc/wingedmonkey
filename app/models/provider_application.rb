# ProviderApplication tableless model

class ProviderApplication
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  extend ProviderModel

  define_model_callbacks :save
  before_save :valid?

  attr_accessor :id, :launchable_id, :name, :state

  validates :name, :presence => true
  validates :launchable_id, :presence => true

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
