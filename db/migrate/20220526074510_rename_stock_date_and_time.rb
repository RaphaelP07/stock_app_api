class RenameStockDateAndTime < ActiveRecord::Migration[7.0]
  def change
    rename_column :stocks, :date_and_time, :date_time
  end
end
