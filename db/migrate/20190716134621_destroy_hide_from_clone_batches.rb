class DestroyHideFromCloneBatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :hidden
  end
end
