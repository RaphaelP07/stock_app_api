class Stock < ApplicationRecord
  def self.top_ten
    top_ten = (JSON.parse(RestClient.get("#{ENV["IEX_BASE_URL"]}/stable/stock/market/list/mostactive?token=#{ENV["IEX_TEST_KEY"]}"))).map { |x| 
      x.select {
        |key|
        key == 'companyName' ||
        key == 'iexOpen' || 
        key == 'latestPrice' ||
        key == 'symbol' 
      }
    }
  end

  def self.info(symbol)
    stock_info = (JSON.parse(RestClient.get("#{ENV["IEX_BASE_URL"]}/stable/stock/#{symbol}/quote?token=#{ENV["IEX_TEST_KEY"]}"))).select { 
      |key| 
      key == 'companyName' ||
      key == 'iexOpen' || 
      key == 'latestPrice' ||
      key == 'symbol' 
    }
  end
  belongs_to :user
end
