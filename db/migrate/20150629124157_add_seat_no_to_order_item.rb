class AddSeatNoToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :seat_no, :integer
  end
end
