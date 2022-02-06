require File.expand_path("#{__dir__}/../lib/notu")
require 'byebug'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }

RSpec.configure(&:raise_errors_for_deprecations!)
