require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  "Will it blend?"
end

get '/club930' do
  url = "http://www.930.com/concerts/"
  page = Nokogiri::HTML(open(url))
  @concerts = page.css('.list-view-item')
  
  erb :show_listing
end

get '/thewilbur'
"Work in Progress"
end

get '/interesting' do
  erb :interesting
end