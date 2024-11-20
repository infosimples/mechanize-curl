# frozen_string_literal: true
##
# Raised when too many redirects are sent

class MechanizeCurl::RedirectLimitReachedError < MechanizeCurl::Error

  attr_reader :page
  attr_reader :redirects
  attr_reader :response_code

  def initialize page, redirects
    @page          = page
    @redirects     = redirects
    @response_code = page.code

    super "Redirect limit of #{redirects} reached"
  end

end

