class AddDismissedToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :dismissed, :integer, :default => 0
    remove_column :inserts, :dismissed
    add_column :inserts, :dismissed, :integer, :default => 0
  end
end
