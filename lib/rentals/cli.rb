require 'nokogiri'
require 'httparty'
require 'byebug'


class Rentals::CLI

  def call
    puts "Find Rentals In Any US Zip Code."
    puts "Please enter a five digit zip code to search available rentals on Realtor.com:"
    zip_code = gets.strip


    puts "Searching https://www.realtor.com/apartments/#{zip_code} for rentals...."
    url = "https://www.realtor.com/apartments/#{zip_code}"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)


    total = parsed_page.css('span#search-result-count.page-title').text.tr("\n","").to_i
    puts "There are #{total} listings in #{zip_code}"


    listings = Array.new
    rental_listings = parsed_page.css('li.component_property-card.js-component_property-card')
    rental_listings.each do |rental_listing|
      listing = {
        address: rental_listing.css('span.listing-street-address').text,
        town: rental_listing.css('span.listing-city').text,
        beds: rental_listing.css('span.data-value.meta-beds-display').text,
        price: rental_listing.css('span.data-price').text
      }
      listings << listing

      puts listing


    end
    
    end
end
