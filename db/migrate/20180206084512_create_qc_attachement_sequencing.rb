class CreateQcAttachementSequencing < ActiveRecord::Migration
  def change
    create_table :qc_attachments_sequencings do |t|
           t.belongs_to :qc_attachment, index: true
           t.belongs_to :sequencing, index: true
     end
    create_table :clone_batches_sequencings do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :sequencing, index: true
     end
     add_column :sequencings, :result, :text
     add_column :sequencings, :conclusion, :boolean
  end
end
