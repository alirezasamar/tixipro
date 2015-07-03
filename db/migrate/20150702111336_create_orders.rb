class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :line_item, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :total_price
      t.string :promo_code
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
