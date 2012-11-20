class BasePresenter
  attr_accessor :object
  def initialize(object, template)
    @object = object
    @template = template
  end

  def h
    @template
  end

  def self.presents(name)
    define_method(name) { return @object }
  end
end
