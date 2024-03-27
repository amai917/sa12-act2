require 'httparty'
require 'json'

def fetch_time_for_timezone(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)

  if response.success?
    JSON.parse(response.body)
  else
    puts "Error fetching time data: #{response.code}"
    exit
  end
end

def display_time(data)
  area_location = data['timezone']
  datetime = DateTime.parse(data['datetime'])
  formatted_time = datetime.strftime('%Y-%m-%d %H:%M:%S')
  puts "The current time in #{area_location} is #{formatted_time}"
end

def main
  if ARGV.length != 2
    puts "Usage: ruby world_time_zone_converter.rb <area> <location>"
    exit
  end
  area = ARGV[0]
  location = ARGV[1]
  time_data = fetch_time_for_timezone(area, location)
  display_time(time_data)
end

main
