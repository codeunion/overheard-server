require_relative 'helper'

class TestListOverheards < FeatureTest
  def test_visiting_the_home_page_reveals_overheards
    Overheard.create({ :body => "Well, when you put it that way I am a horrible person..."})

    visit "/"

    assert_content "Well, when you put it that way"
  end
end
