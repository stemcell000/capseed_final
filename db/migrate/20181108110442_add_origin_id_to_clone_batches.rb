class AddOriginIdToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :origin_id, :integer
    remove_column :clone_batches, :origin_as_plasmid
  end
end
