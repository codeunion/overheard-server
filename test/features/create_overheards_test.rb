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
    create_overheard_request = { :overheard => { :body => random_fake_quote } }
    create_overheard_request_body = JSON.dump(create_overheard_request)

    post("/overheards", create_overheard_request_body, { "CONTENT_TYPE" => "application/json",
                                                         "HTTP_ACCEPT" => "application/json" })

    overheard_in_our_database = Overheard.first({ :body => random_fake_quote })
    refute_nil overheard_in_our_database, "We weren't able to find the overheard in our database"


    assert last_response.ok?, "Response did not return 200"
    assert_equal "application/json",  last_response.content_type

    response_json = JSON.parse(last_response.body)
    assert response_json.has_key?("overheard"), "Response does not include an overheard"
    assert response_json["overheard"]["body"] == random_fake_quote, "Overheard's body did not match the quote we sent"
  end

  def test_creating_an_invalid_overheard_with_json
    create_overheard_request = { :overheard => { } }
    create_overheard_request_body = JSON.dump(create_overheard_request)

    starting_overheard_count = Overheard.count
    post("/overheards", create_overheard_request_body, { "CONTENT_TYPE" => "application/json",
                                                         "HTTP_ACCEPT" => "application/json" })

    assert_equal starting_overheard_count, Overheard.count

    assert last_response.bad_request?, "Response did not return 400"
    assert_equal "application/json",  last_response.content_type

    response_json = JSON.parse(last_response.body)
    assert response_json.has_key?("overheard"), "Response does not include an overheard"
    assert response_json["overheard"].has_key?("errors"), "Response does not include errors for the overheard"
    assert response_json["overheard"]["errors"].has_key?("body"), "Response does not have an error on overheards body"
  end
end
