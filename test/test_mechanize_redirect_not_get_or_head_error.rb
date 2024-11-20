# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeRedirectNotGetOrHead < MechanizeCurl::TestCase

  def test_to_s
    page = fake_page

    error = MechanizeCurl::RedirectNotGetOrHeadError.new(page, :put)

    assert_match(/ PUT /, error.to_s)
  end

end

