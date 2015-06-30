class AddHallToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :hall, index: true, foreign_key: true
  end
end
