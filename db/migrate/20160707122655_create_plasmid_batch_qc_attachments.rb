class CreatePlasmidBatchQcAttachments < ActiveRecord::Migration
  def change
    create_table :plasmid_batch_qc_attachments do |t|
      t.string :attachment

      t.timestamps null: false
    end
  end
end
