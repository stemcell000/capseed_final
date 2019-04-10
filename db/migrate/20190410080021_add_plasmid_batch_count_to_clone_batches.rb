class AddPlasmidBatchCountToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :plasmid_batches_count, :integer, default: 0, null: false
    
    #Populate plasmid_batch_count with counting of existing relations
    
    CloneBatch.find_each{|cb| CloneBatch.reset_counters(cb.id, :plasmid_batches)}
    
  end
end
