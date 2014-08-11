require_relative 'helper'

class TestListOverheards < FeatureTest
  def test_visiting_the_home_page_reveals_overheards
    Overheard.create({ :body => "Well, when you put it that way I am a horrible person..."})

    visit "/"

    assert_content "Well, when you put it that way"
  end

  def test_listing_overheards_as_json

    random_fake_quote = Faker::Lorem.sentence
    fake_overheard = Overheard.create({ :body => random_fake_quote })

    get("/", { "HTTP_ACCEPT" => "application/json" })

    assert last_response.ok?
    assert last_response.content_type == "application/json"

    response_json = JSON.parse(last_response.body)
    assert response_json["overheards"][0]["body"] == random_fake_quote, "The most recently created overheard isn't the one we just created!"
  end
end
