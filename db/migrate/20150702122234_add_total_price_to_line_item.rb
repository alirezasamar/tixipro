class AddTotalPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :total_price, :decimal, precision: 12, scale: 3
  end
end
