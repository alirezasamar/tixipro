class AddUidToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :uid, :string
  end
end
