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

  def zip_code
    puts "************* Find Rentals In Any US Zip Code. *************"
    puts ""
    puts "Please enter a five digit zip code to search available rentals on Realtor.com:"
    zip_code = gets.strip
    url = "https://www.realtor.com/apartments/#{zip_code}"
    puts ""
    puts "Searching https://www.realtor.com/apartments/#{zip_code} for rentals...."
    puts ""
    puts puts "Compiling your listings for #{zip_code}....."
    puts ""
    puts "Here are the available listings for #{zip_code}"
    end

  def prompt
    input = nil
    while input != "exit"
      puts ""
      puts "Enter the listing number that you would like more information on, type new to start a new search, or type exit to quit"
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
