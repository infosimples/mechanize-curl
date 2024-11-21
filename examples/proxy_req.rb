require 'rubygems'
require 'mechanize_curl'

agent = MechanizeCurl.new
agent.set_proxy('localhost', '8000')
page = agent.get(ARGV[0])
puts page.body
