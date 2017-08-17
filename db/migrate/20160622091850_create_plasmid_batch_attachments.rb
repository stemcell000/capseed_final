class CreatePlasmidBatchAttachments < ActiveRecord::Migration
  def change
    create_table :plasmid_batch_attachments do |t|
      t.integer :plasmid_batch_id
      t.string :attachment
      t.timestamps null: false
    end
  end
end
