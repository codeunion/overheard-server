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

    assert_content "Body must not be blank"
    # Prove we see an error message
  end

  def test_creating_a_valid_overheard_with_json
    random_fake_quote = Faker::Lorem.sentence
    create_overheard_request_body = { :overheard => { :body => random_fake_quote } }.to_json

    post("/overheards", create_overheard_request_body, { :content_type => "application/json",
                                          :accept => "application/json" })

    overheard_in_our_database = Overheard.first({ :body => random_fake_quote })
    refute_nil overheard_in_our_database, "We weren't able to find the overheard in our database"


    assert last_response.ok?, "Response did not return 200"

    response_json = JSON.parse(last_response.body)
    assert response_json.has_key?("overheard"), "Response does not include an overheard"
    assert response_body["overheard"]["body"] == random_fake_quote, "Overheard's body did not match the quote we sent"
  end
end
