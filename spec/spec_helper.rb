# frozen_string_literal: true

require 'webmock/rspec'
require_relative "../lib/novu"

RSpec.configure do |config|
  config.expect_with :rspec, :test_unit
  config.mock_with :mocha
  config.pattern = '**/*.spec'
  
  # # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = ".rspec_status"

  # # Disable RSpec exposing methods globally on `Module` and `main`
  # config.disable_monkey_patching!

  # config.expect_with :rspec do |c|
  #   c.syntax = :expect
  # end
end
