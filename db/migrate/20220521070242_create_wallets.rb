class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance
      t.integer :user_id

      t.timestamps
    end
  end
end
