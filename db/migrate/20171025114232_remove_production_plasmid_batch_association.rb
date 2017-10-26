class RemoveProductionPlasmidBatchAssociation < ActiveRecord::Migration
  def change
    remove_column :plasmid_batches, :production_id
    add_column :clone_batches, :production_id, :integer
  end
end
