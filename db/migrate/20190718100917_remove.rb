class Remove < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :clone_batch_user_id
  end
end
