class RemoveDigSmalFromPlasmidBatchQc < ActiveRecord::Migration
  def change
    remove_column :plasmid_batch_qcs, :dig_smal
  end
end
