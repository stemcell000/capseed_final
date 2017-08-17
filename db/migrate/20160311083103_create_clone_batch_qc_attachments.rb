class CreateCloneBatchQcAttachments < ActiveRecord::Migration
  def change
    create_table :clone_batch_qc_attachments do |t|
      t.integer :clone_batch_qc_id
      t.string :attachment

      t.timestamps null: false
    end
  end
end
