require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  erb :home
end

get '/club930' do
  url = "http://www.930.com/concerts/"
  page = Nokogiri::HTML(open(url))
  @concerts = page.css('.list-view-item')
  
  erb :show_listing
end

get '/thewilbur' do
  url = "http://thewilbur.com/"
  page = Nokogiri::HTML(open(url))
  @shows = page.css('.ticket-item')
  
  erb :the_wilbur
end

get '/interesting' do
  erb :interesting
end