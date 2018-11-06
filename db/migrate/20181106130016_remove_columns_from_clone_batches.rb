class RemoveColumnsFromCloneBatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :production_id
    remove_column :clone_batches, :origin_id
    remove_column :clone_batches, :template
  end
end
