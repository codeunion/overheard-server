require 'minitest-capybara'
require 'faker'
require 'overheard'

Capybara.app = Sinatra::Application

class TestCreateOverheards < Minitest::Test

  include Capybara::DSL
  include Capybara::Assertions

  def test_creating_a_valid_overheard
    random_fake_quote = Faker::Lorem.sentence
    visit "/"
    click_on "Add Overheard"

    fill_in "Body", { :with => random_fake_quote }
    click_on "Create Overheard"

    assert_content random_fake_quote
  end
end
