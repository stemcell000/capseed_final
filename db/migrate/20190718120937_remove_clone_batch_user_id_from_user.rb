class RemoveCloneBatchUserIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :clone_batch_user_id
  end
end
