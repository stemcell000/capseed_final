class AddPlasmidBatchToBox < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :clone_batch_id, :integer
  end
end
