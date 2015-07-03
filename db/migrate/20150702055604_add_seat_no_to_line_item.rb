class AddSeatNoToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :seat_no, :integer, default: 0
  end
end
