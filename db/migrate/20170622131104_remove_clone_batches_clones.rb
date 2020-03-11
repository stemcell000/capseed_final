class RemoveCloneBatchesClones < ActiveRecord::Migration
  def change
    drop_table :clone_batches_clones
  end
end
