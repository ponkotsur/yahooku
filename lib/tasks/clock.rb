require 'clockwork'
include Clockwork

every(5.seconds, 'scraping') do
  puts "Scraping.start"
  Scraping.scrape
end