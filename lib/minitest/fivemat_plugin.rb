module Minitest
  class PrairieLearnReporter < Reporter

    def initialize(*args)
      super
      @class = nil
    end

    def record(result)
      if @class != result.klass
        if @class
          #print_elapsed_time(io, @class_start_time)
          io.print "\n"
        end
        @class = result.klass
        @class_start_time = Time.now
        io.print "#@class "
      end
    end

    def report
      super
      #print_elapsed_time(io, @class_start_time) if defined? @class_start_time
    end
  end

  def self.plugin_prairie_learn_init(options)
    if reporter.kind_of?(CompositeReporter)
      reporter.reporters.unshift(PrairieLearnReporter.new(options[:io], options))
    end
  end
end
