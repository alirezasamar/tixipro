class AddSpecialCheckoutToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :special_checkout, :boolean, default: false
  end
end
