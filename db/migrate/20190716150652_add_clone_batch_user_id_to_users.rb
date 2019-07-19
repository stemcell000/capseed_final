class AddCloneBatchUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clone_batch_user_id, :integer
  end
end
