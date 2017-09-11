class RemoveCloneBatchQcsBatches < ActiveRecord::Migration
  def change
    drop_table :clone_batch_qcs_batches
  end
end
