# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeRedirectLimitReachedError < MechanizeCurl::TestCase

  def setup
    super

    @error = MechanizeCurl::RedirectLimitReachedError.new fake_page, 10
  end

  def test_message
    assert_equal 'Redirect limit of 10 reached', @error.message
  end

  def test_redirects
    assert_equal 10, @error.redirects
  end

  def test_response_code
    assert_equal 200, @error.response_code
  end

end

