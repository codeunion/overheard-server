require 'minitest-capybara'
require 'rack/test'
require 'faker'
require 'json'

require 'overheard'

Capybara.app = Sinatra::Application

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Assertions

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
