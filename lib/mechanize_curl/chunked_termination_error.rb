# frozen_string_literal: true
##
# Raised when Mechanize detects the chunked transfer-encoding may be
# incorrectly terminated.

class MechanizeCurl::ChunkedTerminationError < MechanizeCurl::ResponseReadError
end

