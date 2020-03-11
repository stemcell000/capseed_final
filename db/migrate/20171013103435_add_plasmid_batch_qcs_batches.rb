class AddPlasmidBatchQcsBatches < ActiveRecord::Migration
    def self.up
      create_table :plasmid_batch_qcs_batches do |t|
         t.belongs_to :plasmid_batch, index: true
         t.belongs_to :plasmid_batch_qc, index: true
      end
  end
 
  def self.down
    drop_table :plasmid_batch_qcs_batches
  end
end