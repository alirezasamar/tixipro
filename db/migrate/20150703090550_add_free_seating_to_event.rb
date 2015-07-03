class AddFreeSeatingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :free_seating, :boolean, default: false
  end
end
