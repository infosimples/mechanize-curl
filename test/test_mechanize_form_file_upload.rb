# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeFormFileUpload < MechanizeCurl::TestCase

  def test_file_name
    field = node 'input'
    field = MechanizeCurl::Form::FileUpload.new field, 'a&b'

    assert_equal 'a&b', field.file_name
  end

  def test_file_name_entity
    field = node 'input'
    field = MechanizeCurl::Form::FileUpload.new field, 'a&amp;b'

    assert_equal 'a&b', field.file_name
  end

end

