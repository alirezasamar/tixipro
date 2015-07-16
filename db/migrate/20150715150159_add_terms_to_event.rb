class AddTermsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :terms, :text
  end
end
