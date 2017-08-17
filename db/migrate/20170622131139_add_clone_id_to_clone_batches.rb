class AddCloneIdToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :clone_id, :integer
  end
end
