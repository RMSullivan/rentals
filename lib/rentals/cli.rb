class Rentals::CLI

  def call
    puts "Find Rentals In Any US Zip Code."
    puts "Please enter a five digit zip code to search available rentals on Realtor.com:"
    zip_code = gets.strip
    puts "Searching rentals in #{zip_code}...."

    #scraper(zip_code)
  end


end
