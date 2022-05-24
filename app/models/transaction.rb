class Transaction < ApplicationRecord
  belongs_to(
    :wallet,
    class_name: 'Wallet',
    foreign_key: 'wallet_id',
    inverse_of: :transaction
  )
end
