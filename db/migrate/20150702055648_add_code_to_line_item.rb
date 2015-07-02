class AddCodeToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :code, :string
  end
end
