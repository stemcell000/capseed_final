class AddOriginIdToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :origin_id, :integer
  end
end
