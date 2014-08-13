require_relative 'helper'

class TestListOverheards < FeatureTest
  def test_visiting_the_home_page_reveals_overheards
    Overheard.create({ :body => "Well, when you put it that way I am a horrible person..."})

    visit "/"

    assert_content "Well, when you put it that way"
  end

  def test_searching_for_overheards_from_the_home_page
    Overheard.create({ :body => "Foo"})
    Overheard.create({ :body => "Baz"})

    visit "/"
    fill_in "Search", { :with => "Foo" }
    click_on "Search Overheards"

    assert_content "Foo"
    refute_content "Baz"
  end

  def test_listing_overheards_as_json

    first_fake_quote = Faker::Lorem.sentence
    first_fake_overheard = Overheard.create({ :body => first_fake_quote })

    second_fake_quote = Faker::Lorem.sentence
    second_fake_overheard = Overheard.create({ :body => second_fake_quote })

    get("/", "", { "HTTP_ACCEPT" => "application/json" })

    assert last_response.ok?
    assert_equal "application/json", last_response.content_type

    response_json = JSON.parse(last_response.body)

    assert_equal response_json["overheards"][0]["body"], second_fake_quote
  end
end
