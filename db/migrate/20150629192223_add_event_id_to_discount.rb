class AddEventIdToDiscount < ActiveRecord::Migration
  def change
    add_reference :discounts, :event, index: true, foreign_key: true
  end
end
