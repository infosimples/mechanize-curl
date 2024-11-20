# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeFormField < MechanizeCurl::TestCase

  def test_inspect
    field = node 'input'
    field = MechanizeCurl::Form::Field.new field, 'a&b'

    assert_match "value: a&b", field.inspect
  end

  def test_name
    field = node 'input', 'name' => 'a&b'
    field = MechanizeCurl::Form::Field.new field

    assert_equal 'a&b', field.name
  end

  def test_name_entity
    field = node 'input', 'name' => 'a&amp;b'
    field = MechanizeCurl::Form::Field.new field

    assert_equal 'a&b', field.name
  end

  def test_name_entity_numeric
    field = node 'input', 'name' => 'a&#38;b'
    field = MechanizeCurl::Form::Field.new field

    assert_equal 'a&b', field.name
  end

  def test_spaceship
    doc = Nokogiri::HTML::Document.new
    node = doc.create_element('input')
    node['name'] = 'foo'
    node['value'] = 'bar'

    a = MechanizeCurl::Form::Field.new(node)
    b = MechanizeCurl::Form::Field.new({'name' => 'foo'}, 'bar')
    c = MechanizeCurl::Form::Field.new({'name' => 'foo'}, 'bar')

    assert_equal [a, b], [a, b].sort
    assert_equal [a, b], [b, a].sort
    assert_equal [b, c].sort, [b, c].sort
  end

  def test_value
    field = node 'input'
    field = MechanizeCurl::Form::Field.new field, 'a&b'

    assert_equal 'a&b', field.value
  end

  def test_value_entity
    field = node 'input'
    field = MechanizeCurl::Form::Field.new field, 'a&amp;b'

    assert_equal 'a&b', field.value
  end

  def test_value_entity_numeric
    field = node 'input'
    field = MechanizeCurl::Form::Field.new field, 'a&#38;b'

    assert_equal 'a&b', field.value
  end

  def test_raw_value
    field = node 'input'
    field = MechanizeCurl::Form::Field.new field, 'a&amp;b'

    assert_equal 'a&amp;b', field.raw_value
  end

end

