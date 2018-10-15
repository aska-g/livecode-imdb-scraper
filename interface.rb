require 'yaml'
require_relative 'scraper'

puts "Fetching URLs"
movies_urls = fetch_movie_urls
