class AddColumnToPlasmidBatchQcAttachments < ActiveRecord::Migration
  def change
    add_column :plasmid_batch_qc_attachments, :plasmid_batch_qc_id, :integer
  end
end
