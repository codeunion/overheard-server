require_relative 'helper'
class TestCreateOverheards < FeatureTest
  def test_creating_a_valid_overheard
    random_fake_quote = Faker::Lorem.sentence
    visit "/"
    click_on "Add Overheard"

    fill_in "Body", { :with => random_fake_quote }
    click_on "Create Overheard"

    assert_content random_fake_quote
  end
end
