#CLI controller


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
    unless zip_code.length == 5
      puts "Invalid Entry, Please Try Again!"
    else
    url = "https://www.realtor.com/apartments/#{zip_code}"
    puts ""
    puts "Searching https://www.realtor.com/apartments/#{zip_code} for rentals...."
    puts ""
    puts  "Compiling your listings for #{zip_code}....."
    puts ""
    puts "Here are the available listings for #{zip_code}"
    Rentals::Scraper.scrape(zip_code, url)

    listings
    Rentals::Rental.clear

    puts "******************** end of search *********************"
    puts ""
    end
  end

  def listings
    Rentals::Rental.all.each do |rental|
      puts rental.address

    end

    #prints out address

  end

  def prompt
    input = nil
    while input != "exit"
      puts ""
      puts "Type new to start a new search, or type exit to quit"
      input = gets.strip.downcase
      case input
      when "new"
        zip_code
      when "exit"
      else
        puts "Invalid Entry, Please Try Again!"
        puts "Type new to start a new search, or type exit to quit"

      end
    end
  end
  def goodbye
    puts "Check back soon for more listings!"
  end


end
