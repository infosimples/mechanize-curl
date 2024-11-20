require 'rubygems'
require 'mechanize-curl'

agent = MechanizeCurl.new
agent.set_proxy('localhost', '8000')
page = agent.get(ARGV[0])
puts page.body
