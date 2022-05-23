class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.string :company
      t.integer :shares
      t.string :type
      t.decimal :amount
      t.integer :wallet_id

      t.timestamps
    end
  end
end
