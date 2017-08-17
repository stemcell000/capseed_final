class RemoveColumnFromCloneBatchQc < ActiveRecord::Migration
  def change
    remove_column :clone_batch_qcs, :rec_name
  end
end
