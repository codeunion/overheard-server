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
    # If you were to `puts create_overheard_request_body` you'd see that it is a
    # string that looks a lot like a ruby hash but not quite. This is JSON!

    post("/overheards", create_overheard_request_body, { :content_type => "application/json",
                                          :accept => "application/json" })
    # Send a HTTP POST request to "/overheards" with a new overheard formatted
    # as JSON as the request body and HTTP headers of "content_type" and
    # "accept" to application/json

    overheard_in_our_database = Overheard.first({ :body => random_fake_quote })
    refute_nil overheard_in_our_database, "We weren't able to find the overheard in our database"
    # First, we test our application *saved* the overheard into our database


    # Then we verify that the response we send is reasonable
    assert last_response.ok?, "Response did not return 200"

    response_json = JSON.parse(last_response.body)
    # Convert the http responses body from a String of json into a ruby hash

    assert response_json.has_key?("overheard"), "Response does not include an overheard"

    assert response_body["overheard"]["body"] == random_fake_quote, "Overheard's body did not match the quote we sent"

  end
end
