require 'pry'
require 'nokogiri'
require 'open-uri'
SPG_URI = 'http://www.stpaul.gov'
# City of Saint Paul park search pages URI suffixes -- just lists of parks
urls = ['/facilities.aspx?&pagenum=2',
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

(urls).each do |url|

  doc = Nokogiri::HTML(open("#{SPG_URI}#{url}"))

  xpath_predicate = "//tbody/tr[contains(@class, 'ft_results')]/td[contains(@class, 'ft_resultrow')]/a/"
  park_uris = doc.xpath("#{xpath_predicate}@href")
  park_names = doc.xpath("#{xpath_predicate}text()")

  park_uris.each_with_index { |uri, index| 
    puts "#{SPG_URI}#{park_uris[index]}~#{park_names[index]}"
  }
end