require "css"
require "stimulus"

class Stimulus::Controller
  def self.to_css_selector
    CSS::AttrSelector.new(ATTR_NAME, controller_name)
  end

  def to_css_selector
    self.class.to_css_selector
  end
end

class Stimulus::Target
  def to_css_selector
    CSS::AttrSelector.new(attr_name, target_name)
  end
end

class Stimulus::Action
  def to_css_selector
    CSS::AttrSelector.new(ATTR_NAME, attr_value)
  end
end

class Stimulus::Value
  def to_css_selector
    CSS::AttrSelector.new(attr_name, value)
  end
end

class Stimulus::Outlet
  def to_css_selector
    CSS::AttrSelector.new(attr_name, selector)
  end
end

class Stimulus::Param
  def to_css_selector
    CSS::AttrSelector.new(attr_name, value)
  end
end
