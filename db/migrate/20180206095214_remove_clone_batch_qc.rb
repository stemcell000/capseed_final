class RemoveCloneBatchQc < ActiveRecord::Migration
  def change
    drop_table :clone_batch_qcs
    drop_table :clone_batch_qcs_qc_attachments
  end
end
