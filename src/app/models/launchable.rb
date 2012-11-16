class Launchable
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :provider_identifier, :name

  def initialize(provider_identifier, name)
    @provider_identifier, @name =
      provider_identifier, name
  end

  def persisted?
    false
  end
end
