class AddDismissedToInsert < ActiveRecord::Migration
  def change
    add_column :inserts, :dismissed, :boolean, :default => false
  end
end
