class AddPaymentIdToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :payment_id, :integer
  end
end
