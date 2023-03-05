# PrairieLearn test run formatters for RSpec and Cucumber

These formatters generate .json files compatible with PrairieLearn's
external grader specification.

They assume that your test setup relies on a Gemfile and uses `bundle
install` to ensure the right gems are loaded when RSpec or Cucumber run.

## Usage

Start by adding `gem 'prairielearn_formatters'` to your `Gemfile` in
the same section(s) where you require RSpec or Cucumber.

### RSpec

1. For each RSpec example in your autograder tests (beginning with
`it` or `specify`), give the number of points it is worth.  You can do
this in one of two ways:

```ruby
it "does something", :points => 2 do
  # example code here
end
it "does another thing [3 points]" do
  # example code here
end
```

(If a given example has both annotations and they're different, an
exception is raised.)

2. If your autograded exercise relies on a Gemfile, add  `gem
'prairielearn_formatters'` to it, and either invoke RSpec with
`rspec --format PrairieLearn [args]` or add `--format PrairieLearn` to
the `.rspec` file.


### Cucumber

Add `--format Fivemat` to `cucumber.yml`, 
or when running a single command line, say
`cucumber --format PrairieLearn [args]`.

## Contributing

Don't forget to include test coverage for any changes you introduce.

## License

BSD 1-clause license.
