require 'pry'
require 'nokogiri'
require 'open-uri'
SPG_URI = 'http://www.stpaul.gov'
# City of Saint Paul park search pages URI suffixes -- just lists of parks
urls = ['/facilities.aspx?', 
'/facilities.aspx?&pagenum=2',
'/facilities.aspx?&pagenum=3',
'/facilities.aspx?&pagenum=4',
'/facilities.aspx?&pagenum=5',
'/facilities.aspx?&pagenum=6',
'/facilities.aspx?&pagenum=7',
'/facilities.aspx?&pagenum=8',
'/facilities.aspx?&pagenum=9',
'/facilities.aspx?&pagenum=10',
'/facilities.aspx?&pagenum=11',
'/facilities.aspx?&pagenum=12',
'/facilities.aspx?&pagenum=13',
'/facilities.aspx?&pagenum=14',
'/facilities.aspx?&pagenum=15',
'/facilities.aspx?&pagenum=16',
'/facilities.aspx?&pagenum=17',
'/facilities.aspx?&pagenum=18',
'/facilities.aspx?&pagenum=19',
'/facilities.aspx?&pagenum=20',
'/facilities.aspx?&pagenum=21',
'/facilities.aspx?&pagenum=22',
'/facilities.aspx?&pagenum=23',
'/facilities.aspx?&pagenum=24',
'/facilities.aspx?&pagenum=25',
'/facilities.aspx?&pagenum=26',
'/facilities.aspx?&pagenum=27',
'/facilities.aspx?&pagenum=28',
'/facilities.aspx?&pagenum=29',
'/facilities.aspx?&pagenum=30',
'/facilities.aspx?&pagenum=31',
'/facilities.aspx?&pagenum=32',
'/facilities.aspx?&pagenum=33']

# Get park-specific URIs
park_uris = []
(urls).each do |uri|

  doc = Nokogiri::HTML(open("#{SPG_URI}#{uri}"))

  park_uris << doc.xpath("//tbody/tr[contains(@class, 'ft_results')]/td[contains(@class, 'ft_resultrow')]/a/@href")
end

park_uris.flatten!
s_park_uris = []
park_uris.each { |uri| 
  s_park_uris << uri.value
}

# puts "#{s_park_uris}"

# Scrape pages for each park
s_park_uris.each { |uri| 
  doc = Nokogiri::HTML(open("#{SPG_URI}#{uri}"))

  # park name
  park_name = doc.xpath("//span[contains(@class, 'ftdetail_name')]/text()")
  
  # address parts
  address_parts = doc.xpath("//table[contains(@class, 'ftdetail_tbl')]/tr/td[contains(@class, 'r')]/text()")
  street_address = address_parts[0]
  city_state_zip = address_parts[1]
  zip = /[0-9]{5}/.match(city_state_zip).to_s

  #amenities
  # amenity_header = doc.xpath("//b")

  puts "#{uri}~#{park_name}~#{street_address}~#{zip}"
}