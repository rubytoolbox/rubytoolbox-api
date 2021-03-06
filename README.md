<div align="center">
  <img src="https://github.com/rubytoolbox/rubytoolbox/raw/main/app/assets/images/logo/regular.svg?sanitize=true" width="400px" alt="The Ruby Toolbox"/>

  ![CI](https://github.com/rubytoolbox/rubytoolbox-api/workflows/CI/badge.svg)

  **This is a simple ruby APi client for the [Ruby Toolbox API](https://www.ruby-toolbox.com/pages/docs/api/projects)**
</div>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubytoolbox-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubytoolbox-api

## Usage

```ruby
Rubytoolbox::Api.new.compare "rails", "sinatra", "hanami"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rubytoolbox/rubytoolbox-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rubytoolbox/rubytoolbox-api/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubytoolbox::Api project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rubytoolbox/rubytoolbox-api/blob/main/CODE_OF_CONDUCT.md).
