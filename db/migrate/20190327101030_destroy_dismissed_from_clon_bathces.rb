class DestroyDismissedFromClonBathces < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :dismissed
  end
end
