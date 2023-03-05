begin
  require 'minitest'
rescue LoadError
  require 'prairielearn/minitest/unit'
  MiniTest::Unit.runner = PrairieLearn::MiniTest::Unit.new
end
