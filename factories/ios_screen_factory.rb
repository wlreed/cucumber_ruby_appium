require 'singleton'
# ScreenFactory
# Factory pattern that returns screens
class ScreenFactory
  include Singleton
  attr_accessor :screen_name, :screen, :screen_classes, :screen_dictionary

  SCREEN_DICTIONARY = {
    home_screen: 'TheApp',
    login_screen: 'Login',
    user_screen: 'Secret Area'
  }

  SCREEN_MAP = {
    SCREEN_DICTIONARY[:home_screen] => ::HomeScreen,
    SCREEN_DICTIONARY[:login_screen] => ::LoginScreen,
    SCREEN_DICTIONARY[:user_screen] => ::IOSUserScreen
  }

  def fetch_current_screen
    log.info 'fetching screen'
    # screen_name = nil
    current_screen_classes = apm.driver.get_page_class
    @screen if current_screen_classes == @screen_classes

    # check for alerts should probably go here

    current_screen_xml = Nokogiri::XML(apm.driver.driver.page_source)
    elements = current_screen_xml.xpath('//XCUIElementTypeStaticText')
    values = SCREEN_DICTIONARY.values
    elements.each do |element|
      log.debug "CURRENT_ELEMENT: #{element}"
      next unless values.include? element.attr('name')

      log.info "FOUND: #{element.attr('name')}"
      return @screen = SCREEN_MAP.fetch(element.attr('name').to_s).new
    end
  end
end

def screen_factory
  ScreenFactory.instance
end
