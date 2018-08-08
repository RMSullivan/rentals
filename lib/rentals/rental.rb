class Rentals::Rental
  Rentals::Scraper.new
  attr_accessor :address, :town, :number_of_bedrooms, :number_of_bathrooms, :price, :url

  @@all = [ ]

  def initialize(listing)
    @address = listing[0]
    @town = town
    @number_of_bedrooms = number_of_bedrooms
    @price = price
    @url = url

    @@all << self

    end
    def self.all #class reader
      @@all

    end

    def self.clear
      @@all.clear 

    end
  end
