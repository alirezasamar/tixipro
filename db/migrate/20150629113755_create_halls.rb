class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.string :name
      t.string :description
      t.integer :total_seat, default: 0
      t.attachment :seat_view

      t.timestamps null: false
    end
  end
end
