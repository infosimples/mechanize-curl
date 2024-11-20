require 'rubygems'
require 'mechanize-curl'

agent = MechanizeCurl.new
puts agent.get(ARGV[0]).inspect
