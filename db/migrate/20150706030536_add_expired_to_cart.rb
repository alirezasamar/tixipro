class AddExpiredToCart < ActiveRecord::Migration
  def change
    add_column :carts, :expired, :boolean, default: false
  end
end
