class Transaction < ApplicationRecord
  validates :symbol, presence: true, if: :buy_or_sell?
  validates :shares, comparison: { greater_than: 0 }, if: :buy_or_sell?

  belongs_to(
    :wallet,
    class_name: 'Wallet',
    foreign_key: 'wallet_id'
  )

  def buy_or_sell?
    action == 'buy' ||
    action == 'sell'
  end

  def self.buy(wallet_id, symbol, shares)
    stock_info = Stock.info(symbol)
    wallet = Wallet.find(wallet_id)
    amount = shares*stock_info['latestPrice']
    if wallet.update!(balance: wallet['balance'] - amount)
      @transaction = wallet.transactions.create(
        symbol: stock_info['symbol'],
        company: stock_info['companyName'],
        price: stock_info['latestPrice'],
        shares: shares,
        amount: amount,
        action: 'buy',
        wallet_id: wallet_id
        )
      @transaction
    else
      wallet.errors
    end
  end

  def self.sell(wallet_id, symbol, shares)
    stock_info = Stock.info(symbol)
    wallet = Wallet.find(wallet_id)
    amount = shares*stock_info['latestPrice']
    if wallet.update!(balance: wallet['balance'] + amount)
      @transaction = wallet.transactions.create(
        symbol: stock_info['symbol'],
        company: stock_info['companyName'],
        price: stock_info['latestPrice'],
        shares: shares,
        amount: amount,
        action: 'sell',
        wallet_id: wallet_id
        )
      @transaction
    else
      wallet.errors
    end
  end
end
