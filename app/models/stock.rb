class Stock < ApplicationRecord
  def self.top_ten
    top_ten_array = JSON.parse(RestClient.get("#{ENV["IEX_BASE_URL"]}/stable/stock/market/list/mostactive?token=#{ENV["IEX_TEST_KEY"]}"))
  end

  def self.info(symbol)
    stock_info = JSON.parse(RestClient.get("#{ENV["IEX_BASE_URL"]}/stable/stock/#{symbol}/quote?token=#{ENV["IEX_TEST_KEY"]}"))
  end
  belongs_to :user
end
