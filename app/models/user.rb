class User < ApplicationRecord
include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, 
         :recoverable, :rememberable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one(
    :wallets,
    class_name: 'Wallet',
    foreign_key: 'user_id',
    inverse_of: :user,
    dependent: :destroy
  )
end
