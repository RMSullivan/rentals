class Rentals::Scraper
  def self.scrape(zip_code, url)
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    rental_listings = parsed_page.css('li.component_property-card.js-component_property-card')
    rental_listings.each do |rental_listing|

      listing = [
        address = rental_listing.css('span.listing-street-address').text + " " + city = rental_listing.css('span.listing-city').text,
        number_of_bedrooms = rental_listing.css('span.data-value.meta-beds-display').text,
        price = rental_listing.css('span.data-price').text,
        url = "https://www.realtor.com/" + rental_listing.css('div.photo-wrap a').first.attr('href')
      ]
        Rentals::Rental.new(listing)





end
end
end
