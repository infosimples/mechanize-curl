require 'rubygems'
require 'mechanize_curl'

agent = MechanizeCurl.new
puts agent.get(ARGV[0]).inspect
