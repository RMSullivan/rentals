require 'nokogiri'
require 'httparty'
require 'byebug'


class Rentals::CLI

  def call
    puts "************* Find Rentals In Any US Zip Code. *************"
    puts ""
    puts "Please enter a five digit zip code to search available rentals on Realtor.com:"
    zip_code = gets.strip

    url = "https://www.realtor.com/apartments/#{zip_code}"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    total = parsed_page.css('span#search-result-count.page-title').text.tr("\n","").to_i

    puts ""
    puts "Searching https://www.realtor.com/apartments/#{zip_code} for rentals...."
    puts ""
    puts "There are #{total} listings in #{zip_code}"
    puts ""


    listings = Array.new
    rental_listings = parsed_page.css('li.component_property-card.js-component_property-card')
    page = 1
    per_page = rental_listings.count #48
    total = parsed_page.css('span#search-result-count.page-title').text.tr("\n","").to_i
    last_page = 1 + (total / per_page).round #2
    while page <= last_page
       pagination_url = "https://www.realtor.com/apartments/#{zip_code}/pg-#{page}"
       pagination_unparsed_page = HTTParty.get(pagination_url)
       pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
       pagination_rental_listings = pagination_parsed_page.css('li.component_property-card.js-component_property-card')
       pagination_rental_listings.each do |rental_listing|
        listing = {
          address: rental_listing.css('span.listing-street-address').text,
          city: rental_listing.css('span.listing-city').text,
          number_of_bedrooms: rental_listing.css('span.data-value.meta-beds-display').text,
          price: rental_listing.css('span.data-price').text,
        }
        puts listing
        puts ""

      end
      page += 1
    end
    puts "******************** end of search *********************"
    puts ""

  end

end
