class AddPriceToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :price, :decimal
  end
end
