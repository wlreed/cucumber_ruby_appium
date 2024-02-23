require 'singleton'
# ScreenFactory
# Factory pattern that returns screens
class ScreenFactory
  include Singleton
  attr_accessor :screen_name, :screen, :screen_classes, :screen_dictionary

  SCREEN_DICTIONARY = {
    home_screen: 'TheApp',
    login_screen: 'Login',
    user_screen: 'Secret Area',
    echo_box_screen: 'Echo Screen'
  }

  SCREEN_MAP = {
    SCREEN_DICTIONARY[:home_screen] => ::HomeScreen,
    SCREEN_DICTIONARY[:login_screen] => ::AndroidLoginScreen,
    SCREEN_DICTIONARY[:user_screen] => ::AndroidUserScreen,
    SCREEN_DICTIONARY[:echo_box_screen] => ::AndroidEchoBoxScreen
  }

  def fetch_current_screen
    log.info 'fetching screen'
    # screen_name = nil
    current_screen_classes = apm.driver.get_page_class
    @screen if current_screen_classes == @screen_classes

    # check for alerts should probably go here

    current_screen_xml = Nokogiri::XML(apm.driver.driver.page_source)
    elements = current_screen_xml.xpath('//android.widget.TextView')
    values = SCREEN_DICTIONARY.values
    elements.each do |element|
      log.debug "CURRENT_ELEMENT: #{element}"
      next unless values.include? element.attr('text')

      log.info "FOUND: #{element.attr('text')}"
      return @screen = SCREEN_MAP.fetch(element.attr('text').to_s).new
    end
  end
end

def screen_factory
  ScreenFactory.instance
end
