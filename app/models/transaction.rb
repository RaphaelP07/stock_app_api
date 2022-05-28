class Transaction < ApplicationRecord
  validates :symbol, presence: true
  validates :shares, comparison: { greater_than: 0 }

  belongs_to(
    :wallet,
    class_name: 'Wallet',
    foreign_key: 'wallet_id'
  )

  def self.buy(wallet_id, symbol, shares)
    stock_info = Stock.info(symbol)
    @transaction = Wallet.find(wallet_id).transactions.build(
      symbol: stock_info['symbol'], 
      company: stock_info['companyName'], 
      price: stock_info['latestPrice'], 
      shares: shares, 
      amount: shares*stock_info['latestPrice'], 
      action: 'buy',
      wallet_id: wallet_id
      )
    @transaction.wallet.update(balance: @transaction.wallet['balance'] - @transaction[amount])
    if transaction.save && @transaction.wallet['balance'] > @transaction[amount]
      @transaction.save
      @transaction
    else
      @transaction.errors
    end
  end

  def self.sell(wallet_id, symbol, shares)
    stock_info = Stock.info(symbol)
    @transaction = Wallet.find(wallet_id).transactions.build(
      symbol: stock_info['symbol'], 
      company: stock_info['companyName'], 
      price: stock_info['latestPrice'], 
      shares: shares, 
      amount: shares*stock_info['latestPrice'], 
      action: 'sell',
      wallet_id: wallet_id
      )
    @transaction.save
  end
end
