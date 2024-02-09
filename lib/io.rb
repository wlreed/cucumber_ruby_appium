# Monkey Patch that extends Ruby's IO class to split puts into both console and
# log files if defined
#
# because we are monkey patching an existing class, we cannot make the name longer
# which rubocop doesn't like
# rubocop:disable Naming/MethodParameterName
class IO
  @partial_string = nil
  def split_puts(o = nil)
    if log
      if @partial_string
        log.print_cucumber(@partial_string.rstrip)
        @partial_string = nil
      else
        log.print_cucumber(o)
      end
    else
      puts(o)
    end
  end

  def split_print(o = nil)
    if log
      if @partial_string
        @partial_string += o
      else
        @partial_string = o
      end
    else
      print(o)
    end
  end
  # rubocop:enable Naming/MethodParameterName
end
