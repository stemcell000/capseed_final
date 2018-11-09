class RemoveColumnsFromCloneBatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :production_id
  end
end
