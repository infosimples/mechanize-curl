# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizePluggableParser < MechanizeCurl::TestCase

  def setup
    super

    @pp = @mech.pluggable_parser
  end

  def test_aref
    @pp['text/html'] = MechanizeCurl::Download

    assert_equal MechanizeCurl::Download, @pp['text/html']
  end

  def test_csv
    @pp.csv = MechanizeCurl::Download

    assert_equal MechanizeCurl::Download, @pp['text/csv']
  end

  def test_html
    assert_equal MechanizeCurl::Page, @pp['text/html']

    @pp.html = MechanizeCurl::Download

    assert_equal MechanizeCurl::Download, @pp['text/html']
  end

  def test_parser
    assert_equal MechanizeCurl::XmlFile, @pp.parser('text/xml')
    assert_equal MechanizeCurl::File, @pp.parser(nil)
  end

  def test_parser_mime
    @pp['image/png'] = :png

    assert_equal :png, @pp.parser('x-image/x-png')
    assert_equal :png, @pp.parser('image/png')
    assert_equal MechanizeCurl::Image, @pp.parser('image')
  end

  def test_parser_bogus
    assert_nil @pp['bogus']

    assert_equal MechanizeCurl::File, @pp.parser('bogus')
  end

  def test_pdf
    @pp.pdf = MechanizeCurl::Download

    assert_equal MechanizeCurl::Download, @pp['application/pdf']
  end

  def test_xml
    assert_equal MechanizeCurl::XmlFile, @pp['text/xml']
    assert_equal MechanizeCurl::XmlFile, @pp['application/xml']

    @pp.xml = MechanizeCurl::Download

    assert_equal MechanizeCurl::Download, @pp['text/xml']
    assert_equal MechanizeCurl::Download, @pp['application/xml']
  end

end

