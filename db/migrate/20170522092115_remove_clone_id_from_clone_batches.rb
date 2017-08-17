class RemoveCloneIdFromCloneBatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :clone_id
  end
end
