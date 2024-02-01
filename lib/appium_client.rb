require 'singleton'
# AppiumClient
# starts, stops and maintains the client
class AppiumClient
  attr_accessor :driver

  include Singleton

  def setup
    appium_txt = File.join(Dir.pwd, 'appium.txt')
    caps = Appium.load_appium_txt(file: appium_txt)
    @driver = Appium::Driver.new(caps)
  end
end

def apm
  AppiumClient.instance
end
