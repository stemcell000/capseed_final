class RemoveCloneBatchesProductions < ActiveRecord::Migration
  def change
    drop_table :clone_batches_productions
  end
end
