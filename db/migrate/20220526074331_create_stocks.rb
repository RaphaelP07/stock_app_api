class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company
      t.decimal :price
      t.datetime :date_and_time

      t.timestamps
    end
  end
end
