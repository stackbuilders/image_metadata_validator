# ImageMetadataValidator

Welcome to `image_metadata_validator`!. The purpose of this gem is to allow you to easily validate the `width` and `height` of an image uploaded with Carrierwave.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'image_metadata_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install image_metadata_validator

## Usage
For instance if you have a Carrierwave uploader called `BackgroundImageUploader`, you can validate it's with and height in the following way:

```ruby
mount_uploader :background_image, BackgroundImageUploader

validate :background_image, image_width: { greater_than: 500 }
validate :background_image, image_height: { less_than_or_equal_to: 400 }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stackbuilders/image_metadata_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ImageMetadataValidator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/image_metadata_validator/blob/master/CODE_OF_CONDUCT.md).
