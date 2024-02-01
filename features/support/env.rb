require 'appium_lib'
require 'rspec'
require 'test/unit/assertions'

Dir[File.join(File.dirname(__FILE__), '../../lib', '**', '*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '../../screens', '**', '*.rb')].each { |f| require f }

apm_server.setup
apm_server.start_server
# give time for server to start
sleep(10)

apm.setup
apm.driver.start_driver
