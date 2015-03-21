require 'nokogiri'
require 'open-uri'

url = "http://www.930.com/concerts/"

data = Nokogiri::HTML(open(url))

data.css('.list-view-item').each do |concert|
  puts concert.at_css('.summary').text
  puts concert.at_css('.supports').text unless concert.at_css('.supports').nil?
  puts concert.at_css('.dates').text
  puts concert.at_css('.doors').text
  puts concert.at_css('.custom').nil? ? "SOLD OUT" : concert.at_css('.price-range').text.strip
  puts ""
end