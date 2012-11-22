class Provider
  # attr_accessor :name, :type

  def initialize key
    attributes = SETTINGS[:providers][key]
    attributes.each do |name, value|
      # dynamically create attr_accessors for all attributes it polutes the class space http://stackoverflow.com/questions/4964179/how-do-i-set-an-attr-accessor-for-a-dynamic-instance-variable
      # USE OpenStruct INSTEAD http://apidock.com/ruby/OpenStruct
      self.class.send(:attr_accessor, name)
      send("#{name}=", value)
    end
  end

  def self.providers_config
    SETTINGS[:providers]
  end

  # def current_provider
  #   return nil if empty?
  #   provider_config = @providers[self.current_provider_key]
  #   provider_class.new(provider_config) if provider_config
  # end

  # def current_provider_key
  #   Thread.current[:current_provider_key]
  # end

  # def current_provider_key= provider_key
  #   Thread.current[:current_provider_key] = provider_key.to_sym
  # end

  def self.list
    SETTINGS[:providers].reject{|k,v| k == :defaults}.map do |key,provider|
      [provider[:name], key]
    end
  end

  # def empty?
  #   @providers.empty?
  # end

  # private
  # def provider_class
  #   classname = @providers[current_provider_key][:type].capitalize
  #   Providers.const_get(classname).const_get(classname)
  # end
end
