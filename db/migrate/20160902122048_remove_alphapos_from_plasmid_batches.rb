class RemoveAlphaposFromPlasmidBatches < ActiveRecord::Migration
  def change
    remove_column :plasmid_batches, :alphapos, :string
    remove_column :plasmid_batches, :numpos, :string
  end
end
