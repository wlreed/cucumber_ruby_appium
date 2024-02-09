require 'semantic_logger'
require 'singleton'
# ProjectLogging
# handles logs for this project
class ProjectLogging
  attr_reader :logger

  include Singleton
  include SemanticLogger

  # MyFormatter
  class MyFormatter < SemanticLogger::Formatters::Color
    def process_info
      # leave process_info blank
    end

    def name
      # leave name blank
    end

    def time
      Time.new(log.time.to_s).strftime('%Y-%d-%m %H:%M:%S')
    end
  end

  def setup(log_dir)
    SemanticLogger.default_level = :debug
    SemanticLogger.add_appender(file_name: "#{log_dir}/test_log.txt", formatter: ProjectLogging::MyFormatter.new)
    SemanticLogger.add_appender(io: $stdout, formatter: ProjectLogging::MyFormatter.new)
    # SemanticLogger.add_appender(io: $stdout, formatter: :color)
    @logger = SemanticLogger['Test']
    @logger.info('Starting Test Logs')
  end
end

# SemanticLogger
# monkey patching the logger
module SemanticLogger
  # Logger
  class Logger
    # Prints cucumber output without additional formatting
    # Extends the logger class
    #
    # @param [String] text - text to print
    def print_cucumber(text = nil)
      log(:info, text)
      # info text
    end
  end
end

# These are monkey patches for the cucumber formatter
module Cucumber
  # Formatter
  module Formatter
    # Console
    module Console
      def print_element_messages(element_messages, status, kind)
        if element_messages.any?
          @io.puts(format_string("(::) #{status} #{kind} (::)", status))
          @io.split_puts
          @io.flush
        end

        element_messages.each do |message|
          @io.split_puts(format_string(message, status))
          @io.split_puts
          @io.flush
        end
      end

      def print_statistics(duration, config, counts, issues)
        if issues.any?
          @io.split_puts issues.to_s
          @io.split_puts
        end
        @io.split_puts counts.to_s
        @io.split_puts(format_duration(duration)) if duration && config.duration?

        if config.randomize?
          @io.split_puts
          @io.split_puts "Randomized with seed #{config.seed}"
        end

        @io.flush
      end

      def print_exception(exception, status, indent)
        string = exception_message_string(exception, indent)
        @io.split_puts(format_string(string, status))
      end

      def exception_message_string(exception, indent_amount)
        message = "#{exception.message} (#{exception.class})".dup.force_encoding('UTF-8')
        message = linebreaks(message, ENV['CUCUMBER_TRUNCATE_OUTPUT'].to_i)

        indent("#{message}\n#{exception.backtrace.join("\n")}", indent_amount)
      end

      def do_print_snippets(snippet_text_proc)
        snippets = @snippets_input.map do |data|
          snippet_text_proc.call(data.actual_keyword, data.step.text, data.step.multiline_arg)
        end.uniq

        text = "\nYou can implement step definitions for undefined steps with these snippets:\n\n"
        text += snippets.join("\n\n")
        @io.split_puts format_string(text, :undefined)

        @io.split_puts
        @io.flush
      end

      def do_print_passing_wip(passed_messages)
        if passed_messages.any?
          @io.split_puts format_string("\nThe --wip switch was used, so I didn't expect anything to pass. These scenarios passed:", :failed)
          print_element_messages(passed_messages, :passed, 'scenarios')
        else
          @io.split_puts format_string("\nThe --wip switch was used, so the failures were expected. All is good.\n", :passed)
        end
      end

      def attach(src, media_type, filename)
        return unless media_type == 'text/x.cucumber.log+plain'
        return unless @io

        @io.split_puts
        if filename
          @io.split_puts("#{filename}: #{format_string(src, :tag)}")
        else
          @io.split_puts(format_string(src, :tag))
        end

        @io.flush
      end

      def do_print_profile_information(profiles)
        profiles_sentence = if profiles.size == 1
                              profiles.first
                            else
                              "#{profiles[0...-1].join(', ')} and #{profiles.last}"
                            end

        @io.split_puts "Using the #{profiles_sentence} profile#{'s' if profiles.size > 1}..."
      end

      def do_print_undefined_parameter_type_snippet(type_name)
        camelized = type_name.split(/_|-/).collect(&:capitalize).join

        @io.split_puts [
          "The parameter #{type_name} is not defined. You can define a new one with:",
          '',
          'ParameterType(',
          "  name:        '#{type_name}',",
          '  regexp:      /some regexp here/,',
          "  type:        #{camelized},",
          '  # The transformer takes as many arguments as there are capture groups in the regexp,',
          '  # or just one if there are none.',
          "  transformer: ->(s) { #{camelized}.new(s) }",
          ')',
          ''
        ].join("\n")
      end
    end
  end
end

def log
  ProjectLogging.instance.logger
end
