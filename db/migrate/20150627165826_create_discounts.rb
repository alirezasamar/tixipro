class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.integer :ticket_id
      t.integer :discount_percentage
      t.string :code

      t.timestamps null: false
    end
  end
end
