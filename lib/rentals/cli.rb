#CLI controller
require 'nokogiri'
require 'httparty'
require 'byebug'


class Rentals::CLI #class called CLI that is instantiated using the call method

  def call #call method
    zip_code
    prompt
    goodbye

  end

  def  zip_code
    puts "************* Find Rentals In Any US Zip Code. *************"
    puts ""
    puts "Please enter a five digit zip code to search available rentals on Realtor.com:"
    zip_code = gets.strip
    #create an if else to confirm input is a 5 digit number
    url = "https://www.realtor.com/apartments/#{zip_code}"
    puts ""
    puts "Searching https://www.realtor.com/apartments/#{zip_code} for rentals...."
    puts ""
    puts  "Compiling your listings for #{zip_code}....."
    puts ""
    puts "Here are the available listings for #{zip_code}"

    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    total = parsed_page.css('span#search-result-count.page-title').text.tr("\n","").to_i

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
        puts ""
        puts listing
        puts ""

      end
      page += 1
    end
    puts "******************** end of search *********************"
    puts ""

  end
  def prompt
    input = nil
    while input != "exit"
      puts ""
      puts "Enter the listing address for additional details, type new to start a new search, or type exit to quit"
      input = gets.strip.downcase
      case input
      when "1"
        puts "More details about address goes here"
      when "new"
        zip_code
      else
        puts "Invalid Entry, Please Try Again!"
        puts "Enter the listing number for more information, type new to start over, or exit to quit"

      end
    end
  end
  def goodbye
    puts "Check back soon for more listings!"
  end


end
