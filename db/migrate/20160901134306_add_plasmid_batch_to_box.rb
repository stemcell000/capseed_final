class AddPlasmidBatchToBox < ActiveRecord::Migration
  def change
    add_reference :plasmid_batches, :box, index: true, foreign_key: true
  end
end
