class AddAttributesToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :max_seat_no, :integer
    add_column :tickets, :min_seat_no, :integer
  end
end
