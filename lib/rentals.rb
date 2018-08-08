require 'nokogiri'
require 'httparty'
require 'byebug'
require 'pry'

module Rentals #namespacing defined as a module

end

require_relative "rentals/version"
require_relative "rentals/scraper"
require_relative "rentals/rental"
require_relative "rentals/cli"
