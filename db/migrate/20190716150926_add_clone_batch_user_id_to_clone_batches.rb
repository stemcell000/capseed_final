class AddCloneBatchUserIdToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :clone_batch_user_id, :integer
  end
end
