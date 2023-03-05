# PrairieLearn test run formatters for RSpec and Cucumber

These formatters generate .json files compatible with PrairieLearn's
external grader specification.

## Usage

Start by adding `gem 'prairielearn_formatters'` to your `Gemfile` in
the same section(s) where you require RSpec or Cucumber.

### RSpec

Add `--format Fivemat` to `.rspec`, 
or when running a single command line, say 
`rspec --format PrairieLearn [args]`.

### Cucumber

Add `--format Fivemat` to `cucumber.yml`, 
or when running a single command line, say
`cucumber --format PrairieLearn [args]`.

## Contributing

Don't forget to include test coverage for any changes you introduce.

## License

BSD 1-clause license.
