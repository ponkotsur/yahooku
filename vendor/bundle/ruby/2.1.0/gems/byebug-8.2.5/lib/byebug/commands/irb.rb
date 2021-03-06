require 'byebug/command'
require 'irb'

module Byebug
  #
  # Enter IRB from byebug's prompt
  #
  class IrbCommand < Command
    self.allow_in_post_mortem = true

    def self.regexp
      /^\s* irb \s*$/x
    end

    def self.description
      <<-EOD
        irb

        #{short_description}
      EOD
    end

    def self.short_description
      'Starts an IRB session'
    end

    def execute
      unless processor.interface.is_a?(LocalInterface)
        return errmsg(pr('base.errors.only_local'))
      end

      # IRB tries to parse ARGV so we must clear it.  See issue 197
      with_clean_argv { IRB.start(__FILE__) }
    end

    private

    def with_clean_argv
      saved_argv = ARGV.dup
      ARGV.clear
      begin
        yield
      ensure
        ARGV.concat(saved_argv)
      end
    end
  end
end
