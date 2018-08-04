class Rentals::Scraper
  def self.scrape(zip_code, url)
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
          url: "https://www.realtor.com/" + rental_listing.css('div.photo-wrap a').first.attr('href')
        }
        Rentals::Rental.new(listing)



        puts ""
        puts listing
        puts ""

      end
      page += 1
    end
end
end
