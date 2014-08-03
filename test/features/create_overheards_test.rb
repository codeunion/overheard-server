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

  def test_creating_an_invalid_overheard
    visit "/"
    click_on "Add Overheard"

    click_on "Create Overheard"

    assert_equal "/overheards", page.current_path
    # We want to stay on the /overheards page and re-show the form.

    assert_content "Body cannot be empty"
    # Prove we see an error message
  end
end
