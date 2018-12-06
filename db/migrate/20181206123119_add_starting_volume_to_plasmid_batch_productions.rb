class AddStartingVolumeToPlasmidBatchProductions < ActiveRecord::Migration
  def change
    add_column :plasmid_batches_productions, :starting_volume, :decimal
  end
end
