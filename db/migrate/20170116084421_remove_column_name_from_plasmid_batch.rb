class RemoveColumnNameFromPlasmidBatch < ActiveRecord::Migration
  def change
    remove_column :plasmid_batches, :name
  end
end
