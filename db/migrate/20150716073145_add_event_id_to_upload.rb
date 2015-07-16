class AddEventIdToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :event_id, :integer
  end
end
