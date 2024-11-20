# frozen_string_literal: true
##
# This is a pluggable parser that automatically saves every file it
# encounters.  Unlike MechanizeCurl::DirectorySaver, the file saver saves the
# responses as a tree, reflecting the host and file path.
#
# == Example
#
# This example saves all .pdf files
#
#   require 'mechanize-curl'
#
#   agent = MechanizeCurl.new
#   agent.pluggable_parser.pdf = MechanizeCurl::FileSaver
#   agent.get 'http://example.com/foo.pdf'
#
#   Dir['example.com/*'] # => foo.pdf

class MechanizeCurl::FileSaver < MechanizeCurl::Download

  attr_reader :filename

  def initialize uri = nil, response = nil, body_io = nil, code = nil
    @full_path = true

    super

    save @filename
  end

  ##
  # The save_as alias is provided for backwards compatibility with mechanize
  # 2.0.  It will be removed in mechanize 3.
  #--
  # TODO remove in mechanize 3

  alias save_as save

end

