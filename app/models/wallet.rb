class Wallet < ApplicationRecord
  belongs_to :user, :class_name => 'User'

  has_many(
    :transactions,
    class_name: 'Transaction',
    foreign_key: 'wallet_id',
    dependent: :destroy
  )
end
