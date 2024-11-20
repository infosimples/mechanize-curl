# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeRedirectLimitReachedError < MechanizeCurl::TestCase

  def test_to_s
    page = fake_page

    error = MechanizeCurl::ElementNotFoundError.new(page, :element, :conditions)

    assert_match(/element/, error.to_s)
    assert_match(/conditions/, error.to_s)
  end

end

