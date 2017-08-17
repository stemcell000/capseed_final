class AddPositionToPlasmidBatches < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :alphapos, :string
    add_column :plasmid_batches, :numpos, :integer
  end
end
