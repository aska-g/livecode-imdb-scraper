require 'yaml'
require_relative 'scraper'

puts "Fetching URLs"
movies_urls = fetch_movie_urls

movies = movies_urls.map do |movie_url|
  scrape_movie(movie_url)
end

puts "Writing the yml file..."
File.open('movies.yml', 'wb') do |file|
  file.write(movies.to_yaml)
end
