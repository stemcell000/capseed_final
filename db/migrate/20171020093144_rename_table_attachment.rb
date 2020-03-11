class RenameTableAttachment < ActiveRecord::Migration
  def change
    rename_table :clone_batch_qc_attachments, :qc_attachments
  end
end
