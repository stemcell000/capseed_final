class RenameCloneBatchCloneBatchqc < ActiveRecord::Migration
  def change
    rename_table :clone_batches_clone_batche_qcs, :clone_batch_qcs_batches
  end
end
