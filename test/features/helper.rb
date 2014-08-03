require 'minitest-capybara'
require 'faker'
require 'overheard'

Capybara.app = Sinatra::Application

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Assertions

end
