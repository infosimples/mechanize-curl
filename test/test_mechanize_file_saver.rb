# frozen_string_literal: true
require 'mechanize_curl/test_case'

class TestMechanizeFileSaver < MechanizeCurl::TestCase

  def setup
    super

    @uri = URI 'http://example'
    @io = StringIO.new 'hello world'
  end

  def test_initialize
    in_tmpdir do
      MechanizeCurl::FileSaver.new @uri, nil, @io, 200

      assert File.exist? 'example/index.html'
    end
  end

end

