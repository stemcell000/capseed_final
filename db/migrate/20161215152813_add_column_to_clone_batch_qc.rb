class AddColumnToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :user_id, :integer
  end
end
