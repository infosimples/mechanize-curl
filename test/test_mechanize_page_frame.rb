# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizePageFrame < MechanizeCurl::TestCase

  def test_content
    page = page 'http://example/referer'
    frame = node 'frame', 'name' => 'frame1', 'src' => 'http://example/'
    frame = MechanizeCurl::Page::Frame.new frame, @mech, page

    frame.content

    assert_equal 'http://example/referer', requests.first['Referer']
  end

end

