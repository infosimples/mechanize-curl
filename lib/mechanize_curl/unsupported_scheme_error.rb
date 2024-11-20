# frozen_string_literal: true
class MechanizeCurl::UnsupportedSchemeError < MechanizeCurl::Error
  attr_accessor :scheme, :uri

  def initialize(scheme, uri)
    @scheme = scheme
    @uri    = uri
  end
end
