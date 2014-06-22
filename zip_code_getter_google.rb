require 'net/http'
require 'net/https'
require 'pry'
require 'rubygems'
require 'json'

# This requires a Google API key: https://developers.google.com/maps/documentation/geocoding/
api_key = ARGV[0]

# Brooklyn Park city parks
street_addresses = ['6665 Boone Ave.',
'4520 81st Ave.',
'7650 June Ave.',
'8232 Regent Ave.',
'9161 Hampshire Ave.',
'73rd Ave and Noble Ave.',
'1750 87th Trail.',
'6249 Cavelle Ave.',
'8440 Regent Ave.',
'7750 Girard Ave.',
'64th and Xylon Ave.',
'8233 W. Broadway.',
'5600 85th Ave.',
'3640 84th Ave.',
'83rd and Zane.',
'8717 Zane Ave.',
'2900 Edinbrook Pkwy.',
'8700 Edinbrook Crossing.',
'6350 Edgewood Ave.',
'8321 Emerson Ave.',
'10201 West River Road.',
'6600 Zane Ave.',
'10001 Noble Ave.',
'7880 Mt. Curve Blvd.',
'6101 Candlewood Dr.',
'7300 Florida Ave.',
'4345 101st Ave. No.',
'7440 Irving Ave.',
'1400 89th Ave.',
'8001 Lad Pkwy.',
'6901 66th Ave.',
'8900 Vickors Crossin.',
'6216 Boone Ave.',
'700 Meadowwood Dr.',
'97th and Noble Ave.',
'10201 West River Rd.',
'10201 Fallgold Parkwa.',
'7600 107th Ave.',
'8100 Newton Ave.',
'10251 Zane Ave.',
'2401 Brookdale Ct.',
'7759 Kentucky Ave.',
'9432 Fallgold Pkwy.',
'8245 Queen Ave.',
'200 81st Ave. No.',
'9401 Upton Ave.',
'7340 Regent Ave.',
'6410 62nd Ave.',
'2624 87th Trail No.',
'7708 Iris Dr.',
'1201 82nd Ave.',
'5425 83rd Ave.',
'6240 Sunnylane Ave.',
'5300 Edinbrook Terrace.',
'8726 Maryland Ave.',
'7890 Tessman Dr.',
'9041 Prestwick Pkwy.',
'8416 Westwood Rd.',
'7719 Brooklyn Blvd.',
'5900 Garwood.',
'9838 Fallgold Pkwy.',
'1909 95th Ave.',
'7227 Zane Ave.',
'7100 Zane Ave.',
'8717 Zane Ave.']

street_addresses.each do |street_address|
  street_address.gsub!(' ','+')

  uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{street_address},+Brooklyn+Park,+MN&key=#{api_key}")

  Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri

    response = http.request request

    jsn = JSON.parse(response.body)
    formatted_address = jsn["results"][0]["formatted_address"]
    zip = ''
    jsn["results"][0]["address_components"].each do |record|
      zip = record["short_name"] if record["types"].include?("postal_code")
    end

    puts "#{formatted_address}~#{zip}"
  end

end