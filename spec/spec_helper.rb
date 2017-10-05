# $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
# $LOAD_PATH.unshift(File.dirname(__FILE__) + '/resources')

require 'rspec'
require 'sqlite3'
require 'active_record'
require 'active_record/base'
require 'active_record/migration'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'

require_relative '../lib/image_metadata_validator'
require_relative 'resources/user'
require_relative 'fixtures'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(
  "adapter"   => "sqlite3",
  "database"  => ":memory:"
)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.include SpecHelpers::Fixtures

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
