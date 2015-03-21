require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  url = "http://www.930.com/concerts/"
  page = Nokogiri::HTML(open(url))
  @concerts = page.css('.list-view-item')
  
  erb :show_listing
end

get '/interesting' do
  erb :interesting
end