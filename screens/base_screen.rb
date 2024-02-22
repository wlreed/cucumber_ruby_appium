# BaseScreen
# basic screen that all others inherit from
# this is the place to store all generic methods that have no OS bias
class BaseScreen
  def initialize
    raise StandardError, "`#{self.class}` is a Parent class and cannot be initialized" if self.instance_of? BaseScreen

    log.info "initializing #{self.class}"
  end

  # method_missing
  #
  # Currently only used to provide the 'click' methods for each button in
  #  this object and child objects.  Calling a method that begins with 'click_'
  #  will cause it to match to the rest of the parameter.  As long as that is
  #  one of the available button methods it will click it.
  def method_missing(click_button)
    if click_button.to_s =~ /^click_/
      button_string = click_button.to_s
      # Clear out 'click_' from button_string
      button_string.slice!(0..5)
      # Log the newly edited button
      log.info "Clicking #{button_string}"
      # Sending the string to self calls the method from the child
      button = send(button_string)
      button.click
      sleep(1)
    else
      super
    end
  end

  # respond_to_missing?
  #
  # Required by method_missing.  Allows us to programmatically determine
  #  which methods are available in this class
  def respond_to_missing?(method_name, *arguments)
    if method_name.to_s =~ /^click_/
      self == method_name
    else
      super
    end
  end

  def find_element(type, identifier)
    apm.driver.wait { apm.driver.find_element(type, identifier) }
  rescue Appium::Core::Wait::TimeoutError
    log.warn "Could not find element with '#{type}' and '#{identifier}' parameters"
    # apm.driver.page
    apm.driver.get_page_class
    raise
  end

  def find_element_by_name_and_type(name, type)
    elements = find_elements(type)
    elements.each do |element|
      log.debug "Looking for '#{name}' got: '#{element.name}'"
      return element if element.name.eql? name
    end
    log.warn "Could not find element with '#{name}' and '#{type}' parameters"
    log.info apm.driver.get_page_class
    raise StandardError
  end

  def find_elements(type)
    apm.driver.wait { apm.driver.find_elements(:class_name, type) }
  end

  def find_element_by_tag(tag)
    apm.driver.tag(tag)
  end
end
