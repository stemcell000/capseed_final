class AddCloneBatchQcsBatches < ActiveRecord::Migration
  def self.up
      create_table :clone_batch_qcs_batches do |t|
         t.belongs_to :clone_batch, index: true
         t.belongs_to :clone_batch_qc, index: true
      end
  end
 
  def self.down
    drop_table :clone_batch_qcs_batches
  end



end
