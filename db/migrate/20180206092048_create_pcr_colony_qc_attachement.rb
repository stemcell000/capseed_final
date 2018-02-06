class CreatePcrColonyQcAttachement < ActiveRecord::Migration
  def change
    create_table :pcr_colonies_qc_attachments do |t|
           t.belongs_to :pcr_colony, index: true
           t.belongs_to :qc_attachment, index: true
     end
    create_table :clone_batches_pcr_colonies do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :pcr_colony, index: true
     end
      add_column :pcr_colonies, :result, :text
      add_column :pcr_colonies, :conclusion, :boolean
  end
end
