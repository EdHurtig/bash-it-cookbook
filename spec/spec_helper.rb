require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end

at_exit { ChefSpec::Coverage.report! }
