class AddAttributesToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :currency_type, :string
    add_column :payments, :transaction_amount, :decimal
  end
end
