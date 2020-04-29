# Scraping with Nokogiri!

## Key Topics:
# 1. What is Scraping?
# 2. How to use Nokogiri
# 3. Creating instances with Nokogiri
# 4. Scraping "2 layers deep"
# 5. Making a Scraper class

require 'nokogiri'
require 'open-uri'
require 'pry'

class Review

  @@all = []

  attr_accessor :album_title, :artist_name, :reviewer_name

  def initialize(album_title, artist_name, reviewer_name)
    @album_title = album_title
    @artist_name = artist_name
    @reviewer_name = reviewer_name
    @@all << self
  end

  def self.all
    @@all
  end

end

base_url = "https://pitchfork.com/reviews/albums/"

html_to_elements = open(base_url)

parsed_html_elements = Nokogiri::HTML(html_to_elements)

review_elements = parsed_html_elements.css('.review')

binding.pry
#1. When you're preparing to scrape, look at a page and try to find out what each element that holds information that you want has in common.

#In this case, every review is housed in a div tag with the classname of "review"

#2. Use the selector to collect an array of the elements that you want to iterate over. In this case, we used .css('.review') to collect all of the review elements that house the information that we need for our app

#3. Determine the selectors that grab the pertinent information inside each element. In this case we used :

#element.css('.artist-list').text to grab the name of the artist
#element.css('h2').text to grab the name of the album
#element.css('.display-name--linked').text to grab the reviewer's name

#4. Iterate over each element, apply the selectors and save the values to variables, pass the variables as arguments to the new instance of your class.

review_elements.map do |element|
  artist_name = element.css('.artist-list').text
  album_title = element.css('h2').text
  reviewer_name = element.css('.display-name--linked').text
  new_review = Review.new(album_title, artist_name, reviewer_name)
  binding.pry
end

Review.all.each do |review|
  puts review.artist_name
  puts review.album_title
  puts review.reviewer_name
  puts "=================="
end

[1, 2, 3, 4].map{|num| num * 2}

#map - returns the same amount of elements as the initial collection BUT does transformation on each one
#select
#find
#each - always returns the initial collection, doesn't matter what you do in the block


#https://www.w3schools.com/cssref/css_selectors.asp
#two ways to grab elements by their css
# tag selector => div, h2, h1, p, span
# class selector uses the '.'

#### WELCOME TO THE PITCHFORK APP
### HERE ARE THE 12 MOST RECENT PITCHFORK REVIEWS

#1. YoungBoy Never Broke Again by Alphonse Pierre
#2 Chuky 73 / Fetti031 by Matthew Ismael Ruiz
#...etz

# Type in the number of the review to see more

# 3
# The Italian electronic producer and arch conceptualist finds a new flamboyance in astoundingly ornate, song-like pieces of deconstructed trance and video-game chirps.

0
