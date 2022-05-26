require 'date'

BASE_URL = "https://sandbox.iexapis.com"
list_of_symbols = "#{BASE_URL}/beta/ref-data/symbols?token=#{ENV["IEX_TEST_KEY"]}"
top_ten_active = "#{BASE_URL}/stable/stock/market/list/mostactive?token=#{ENV["IEX_TEST_KEY"]}"
top_three_gainers = "#{BASE_URL}/stable/stock/market/list/gainers?token=#{ENV["IEX_TEST_KEY"]}"
stock_info = "#{BASE_URL}/stable/stock/fb/quote?token=#{ENV["IEX_TEST_KEY"]}"

top_ten_array = JSON.parse(RestClient.get(top_ten_active))
# top_ten_array.each do |item| p "#{item["symbol"]} => $#{item["latestPrice"]}" end
# debugger

Stock.destroy_all

top_ten_array.each do |item| 
  Stock.create(symbol: item["symbol"], company: item["companyName"], price: item["latestPrice"], date_time: DateTime.now)
end

p Stock.all
