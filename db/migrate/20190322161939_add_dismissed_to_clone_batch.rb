class AddDismissedToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :dismissed, :boolean, :default => false
  end
end
