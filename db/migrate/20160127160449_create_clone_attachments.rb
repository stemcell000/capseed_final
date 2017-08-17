class CreateCloneAttachments < ActiveRecord::Migration
  def change
    create_table :clone_attachments do |t|
      t.integer :clone_id
      t.string :attachment

      t.timestamps null: false
    end
  end
end
