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

  IOS_SCREEN_MAP = {
    SCREEN_DICTIONARY[:home_screen] => ::HomeScreen,
    SCREEN_DICTIONARY[:login_screen] => ::LoginScreen,
    SCREEN_DICTIONARY[:user_screen] => ::IOSUserScreen
  }

  ANDROID_SCREEN_MAP = {
    SCREEN_DICTIONARY[:home_screen] => ::HomeScreen,
    SCREEN_DICTIONARY[:login_screen] => ::LoginScreen,
    SCREEN_DICTIONARY[:user_screen] => ::AndroidUserScreen
  }

  def os_screen_map
    if apm.caps[:caps][:platformName].downcase == 'ios'
      ::IOSUserScreen
    else
      ::AndroidUserScreen
    end
  end

  def fetch_current_screen
    puts 'fetching screen'
    # screen_name = nil
    current_screen_classes = apm.driver.get_page_class
    @screen if current_screen_classes == @screen_classes

    # check for alerts should probably go here

    current_screen_xml = Nokogiri::XML(apm.driver.driver.page_source)
    elements = current_screen_xml.xpath('//XCUIElementTypeStaticText')
    values = SCREEN_DICTIONARY.values
    elements.each do |element|
      puts "CURRENT_ELEMENT: #{element}"
      if values.include? element.attr('name')
        puts "FOUND: #{element.attr('name')}"
        if apm.caps[:caps][:platformName].downcase == 'ios'
            return @screen = IOS_SCREEN_MAP.fetch(element.attr('name').to_s).new
        else
            return @screen = ANDROID_SCREEN_MAP.fetch(element.attr('name').to_s).new
        end
      end
    end
  end
end

def screen_factory
  ScreenFactory.instance
end
