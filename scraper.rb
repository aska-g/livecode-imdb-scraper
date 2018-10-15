require 'open-uri'
require 'nokogiri'

# regex for movie title and year from the main url:
# regex = /(?<title>.*)\W\((?<year>\d{4})/

def fetch_movie_urls()
  url = "https://www.imdb.com/chart/top"
  html_file = open(url).read
  array_of_links = []
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search(".titleColumn a").take(5).each do |element|
    link = element.attributes['href'].value
    short_link = URI.parse(link)
    short_link.scheme = 'http'
    short_link.host = 'www.imdb.com'
    short_link.query = nil
    array_of_links << short_link.to_s
  end
  return array_of_links
end

def scrape_movie(link)
  html_file = open(link).read
  movie_string = Nokogiri::HTML(html_file)
  title = movie_string.search("h1").text
  year = movie_string.search("#titleYear").text
  storyline = movie_string.search('.summary_text').text.strip
  rating = movie_string.search('.ratingValue').text

  {
    storyline: storyline,
    title: title,
    year: year,
    rating: rating
  }

end

scrape_movie('https://www.imdb.com/title/tt0111161')
