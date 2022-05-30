class Wallet < ApplicationRecord
  validates :balance, comparison: { greater_than: 0 }
  belongs_to :user, :class_name => 'User'

  has_many(
    :transactions,
    class_name: 'Transaction',
    foreign_key: 'wallet_id',
    dependent: :destroy
  )

  def self.cash_in(id, amount)
    Wallet.find(id).update(balance: Wallet.find(id)['balance'] + amount)
  end

  def self.cash_out(id, amount)
    Wallet.find(id).update(balance: Wallet.find(id)['balance'] - amount)
  end
end
