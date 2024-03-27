require 'httparty'
require 'json'

def fetch_cryptocurrency_data
  url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'
  response = HTTParty.get(url)

  if response.success?
    JSON.parse(response.body)
  else
    puts "Error fetching cryptocurrency data: #{response.code}"
    exit
  end
end

def sort_cryptocurrencies(data)
  data.sort_by { |coin| -coin['market_cap'] }
end

def display_top_cryptocurrencies(sorted_data)
  sorted_data.first(5).each_with_index do |coin, index|
    puts "#{index + 1}: #{coin['name']} - $#{coin['current_price']} (Market Cap: $#{coin['market_cap']})"
  end
end

def main
  data = fetch_cryptocurrency_data
  sorted_data = sort_cryptocurrencies(data)
  display_top_cryptocurrencies(sorted_data)
end

main
