# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeResponseReadError < MechanizeCurl::TestCase

  def setup
    super

    @error = 'error message'
    @response = Response.new
    @response['content-length'] = 3
    @body_io = StringIO.new 'body'
  end

  def test_force_parse
    @response['content-type'] = 'text/html'
    uri = URI 'http://example/'

    e = MechanizeCurl::ResponseReadError.new @error, @response, @body_io, uri, @mech

    page = e.force_parse

    assert_kind_of MechanizeCurl::Page, page
    assert_equal 'body',            page.body
    assert_equal @mech,             page.mech
  end

end

