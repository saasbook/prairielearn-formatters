puts "**loading**"
module PrairieLearn
  autoload :Cucumber, 'prairie_learn/cucumber'
  autoload :Cucumber3, 'prairie_learn/cucumber3'
  autoload :MiniTest, 'prairie_learn/minitest/unit'
  autoload :RSpec, 'prairie_learn/rspec'
  autoload :RSpec3, 'prairie_learn/rspec3'
  autoload :Spec, 'prairie_learn/spec'

  def cucumber3?
    defined?(::Cucumber) && ::Cucumber::VERSION >= '3'
  end
  module_function :cucumber3?

  # Cucumber detects the formatter API based on initialize arity
  if cucumber3?
    def initialize(config)
    end
  else
    def initialize(runtime, path_or_io, options)
    end
  end

  def rspec3?
    defined?(::RSpec::Core) && ::RSpec::Core::Version::STRING >= '3.0.0'
  end
  module_function :rspec3?

  if rspec3?
    puts "**rspec3 detect"
    # This needs to be run before `.new` is called, so putting it inside the
    # autoloaded rspec3 file will not work.
    ::RSpec::Core::Formatters.register(self,
    :example_started,           # collect points from example name
    :example_passed,            # when example passes, record points earned
    :example_failed,            # when example fails, capture error message
    :example_pending,           # when example pending... (TBD)
    #:example_group_started,
    #:example_group_finished,
    # :dump_summary,
    # :seed,
    # :message,
    # :example_group_finished,
    # :example_section_finished,
    :close)                     # when run is over, emit JSON
  end

  def self.new(*args)
    formatter = 
      case args.size
      when 0 then MiniTest::Unit
      when 1 then
        if args.first.class.to_s == "Cucumber::Configuration"
          Cucumber3
        elsif rspec3?
          puts "***************"
          RSpec3
        else
          RSpec
        end
      when 2 then Spec
      when 3
        Cucumber
      else
        raise ArgumentError
      end
    formatter.new(*args)
  end
end
