# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeSubclass < MechanizeCurl::TestCase

  class Parent < Mechanize
    @html_parser = :parser
    @log = :log
  end

  class Child < Parent
  end

  def test_subclass_inherits_html_parser
    assert_equal :parser, Child.html_parser
  end

  def test_subclass_inherits_log
    assert_equal :log, Child.log
  end

end

