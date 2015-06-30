class AddPaidToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :paid, :boolean, default: false
  end
end
