class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :ticket_type
      t.decimal :price, precision: 5, scale: 2
      t.integer :quantity
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
