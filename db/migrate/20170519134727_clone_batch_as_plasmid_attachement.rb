class CloneBatchAsPlasmidAttachement < ActiveRecord::Migration
  def change
      create_table :clone_batch_as_plasmid_attachments do |t|
      t.integer :clone_batch_id
      t.string :attachment
      t.timestamps null: false
     end
  end
end
