require 'semantic_logger'
require 'singleton'
# ProjectLogging
# handles logs for this project
class ProjectLogging
  attr_reader :logger

  include Singleton
  include SemanticLogger

  # MyFormatter
  class MyFormatter < SemanticLogger::Formatters::Default
    def process_info
      # leave process_info blank
    end

    def time
      Time.new(log.time.to_s).strftime('%Y-%d-%m %H:%M:%S')
    end
  end

  def setup(log_dir)
    SemanticLogger.default_level = :info
    SemanticLogger.add_appender(file_name: "#{log_dir}/test_log.txt", formatter: ProjectLogging::MyFormatter.new)
    SemanticLogger.add_appender(io: $stdout, formatter: :color)
    @logger = SemanticLogger['Test']
    @logger.info('Starting Test Logs')
  end
end

module SemanticLogger
  # Logger
  class Logger
    # Prints cucumber output without additional formatting
    # Extends the logger class
    #
    # @param [String] text - text to print
    def print_cucumber(text = nil)
      info text
    end
  end
end

def log
  ProjectLogging.instance.logger
end
