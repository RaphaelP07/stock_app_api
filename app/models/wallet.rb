class Wallet < ApplicationRecord
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: 'user_id',
    inverse_of: :wallets
  )

  has_many(
    :transactions,
    class_name: 'Transaction',
    foreign_key: 'wallet_id',
    inverse_of: :wallet,
    dependent: :destroy
  )
end
