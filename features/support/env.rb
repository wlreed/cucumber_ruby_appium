require 'appium_lib'
require 'rspec'
require 'test/unit/assertions'
require 'semantic_logger'

Dir[File.join(File.dirname(__FILE__), '../../lib', '**', '*.rb')].each { |f| require f }
# Base screen need to be loaded before dependencies
require_relative '../../screens/base_screen'
Dir[File.join(File.dirname(__FILE__), '../../screens', '**', '*.rb')].each { |f| require f }

# set up results directory
@results_dir = 'results'
FileUtils.mkdir(@results_dir) unless File.exist?(@results_dir)
@log_dir = "#{@results_dir}/#{Time.now.strftime('%h-%d_%H.%M.%S')}"
FileUtils.mkdir_p(@log_dir)
ProjectLogging.instance.setup(@log_dir)

apm_server.setup
apm_server.start_server(@log_dir)
# give time for server to start
sleep(10)

# setup and start client
apm.setup
apm.driver.start_driver

# Dir[File.join(File.dirname(__FILE__), '../../factories', '**', '*.rb')].each { |f| require f }
if apm.caps[:caps][:platformName].downcase == 'ios'
  require_relative '../../factories/ios_screen_factory'
else
  require_relative '../../factories/android_screen_factory'
end
