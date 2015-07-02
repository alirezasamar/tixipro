class AddAttributesToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :max_seat_no, :integer, default: 0
    add_column :tickets, :min_seat_no, :integer, default: 0
  end
end
