module PrairieLearn
  class RSpec3
    
    # @see https://prairielearn.readthedocs.io/en/latest/externalGrading/

    # see ../prairie_learn.rb for which callbacks are registered.  This is the new,
    # less-intuitive way of doing things with Rspec 3

    def initialize(output)
      @output_stream = output
      @test_report = PrairieLearn::TestReport.new(
        :gradable => true,
        :score => 0.0,
        :message => 'Tests ran successfully',
        :output => '',
        :tests => [])
      @current_test_case = nil # when an example starts, this gets set to a struct that will capture example's results
      @sequence = 0
    end

    # @see https://www.rubydoc.info/gems/rspec-core/RSpec/Core/Notifications
    # @see https://www.rubydoc.info/gems/rspec-core/RSpec/Core/Example
    def example_started(notification)
      example = notification.example # an instance of RSpec::Core::Example
      @sequence += 1
      @current_test_case = PrairieLearn::TestCase.new(
        :name => "Test #{@sequence}",
        :description => example.full_description,
        :points => 0,
        :max_points => extract_points(example),
        :output => '',
        :message => '')
    end

    def example_passed(notification)
      @current_test_case.points = @current_test_case.max_points
      @current_test_case.output = DEFAULT_PASS_MESSAGE
      @test_report.output << sprintf("%2d. %s", @sequence, DEFAULT_PASS_MESSAGE)
      @test_report.tests << @current_test_case
    end

    def example_failed(notification)
      fail_exception = notification.example.exception # the reason the test failed
      @current_test_case.output = fail_exception.message
      @current_test_case.points = 0
      @test_report.output << sprintf("%2d. %s", @sequence, DEFAULT_FAIL_MESSAGE)
      @test_report.tests << @current_test_case
    end

    def example_pending(notification)
      @test_report.output << sprintf("%2d. %s", @sequence, DEFAULT_UNEXECUTED_MESSAGE)
      # make sure we DON'T even try to count this test case in total points
      @current_test_case.points =
        @current_test_case.max_points = 0
      @test_report.tests << @current_test_case
    end

    def close(notification)
      json = PrairieLearn.finalize_and_jsonify(@test_report)
      @output_stream.puts json
    end

    private

    def extract_points(example)
      # if an example's metadata has :points => N, extract that.
      # elsif its description includes "[N points]", extract that.
      # if it has both and they match, issue a warning
      # if it has both and they don't match, issue an error
      points_from_metadata = example.metadata.has_key?(:points) ? example.metadata[:points].to_i : nil
      points_from_description = example.description =~ /\[\s*(\d+)\s*points?\s*\]\s*$/ ? $1.to_i : nil
      if points_from_metadata && points_from_description
        # if they are equal, warning for example.metadata[:location] (file path + line num)
        if points_from_metadata == points_from_description
        # puts "#{example.metadata[:location]}: points given in both metadata and example docstring"
        else
          raise RuntimeError.new("#{example.metadata[:location]}: points given in both metadata and example docstring, and they don't match")
        end
        points_from_metadata
      else
        points_from_metadata || points_from_description || 0
      end
    end
  end
end
