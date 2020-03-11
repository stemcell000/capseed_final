class RemoveItrFrompPlasmidBatchQc < ActiveRecord::Migration
  def change
    remove_column :plasmid_batch_qcs, :itr
  end
end
