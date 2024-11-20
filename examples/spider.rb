require 'rubygems'
require 'mechanize-curl'

agent = MechanizeCurl.new
agent.max_history = nil # unlimited history
stack = agent.get(ARGV[0]).links

while l = stack.pop
  next unless l.uri
  host = l.uri.host
  next unless host.nil? or host == agent.history.first.uri.host
  next if agent.visited? l.href

  puts "crawling #{l.uri}"
  begin
    page = l.click
    next unless MechanizeCurl::Page === page
    stack.push(*page.links)
  rescue MechanizeCurl::ResponseCodeError
  end
end

