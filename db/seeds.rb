require 'date'

list_of_symbols = "#{ENV["IEX_BASE_URL"]}/beta/ref-data/symbols?token=#{ENV["IEX_TEST_KEY"]}"
top_ten_active = "#{ENV["IEX_BASE_URL"]}/stable/stock/market/list/mostactive?token=#{ENV["IEX_TEST_KEY"]}"
top_three_gainers = "#{ENV["IEX_BASE_URL"]}/stable/stock/market/list/gainers?token=#{ENV["IEX_TEST_KEY"]}"
stock_info = "#{ENV["IEX_BASE_URL"]}/stable/stock/fb/quote?token=#{ENV["IEX_TEST_KEY"]}"

top_ten_array = Stock.top_ten
# top_ten_array.each do |item| p "#{item["symbol"]} => $#{item["latestPrice"]}" end
# debugger

Stock.destroy_all

top_ten_array.each do |item| 
  Stock.create(symbol: item["symbol"], company: item["companyName"], price: item["latestPrice"], date_time: DateTime.now)
end 

p Stock.all
