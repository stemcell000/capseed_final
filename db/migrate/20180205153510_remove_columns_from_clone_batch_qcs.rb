class RemoveColumnsFromCloneBatchQcs < ActiveRecord::Migration
  def change
    remove_column :clone_batch_qcs, :date_send
    remove_column :clone_batch_qcs, :date_rec
    remove_column :clone_batch_qcs, :user_id
    remove_column :clone_batch_qcs, :primer1
    remove_column :clone_batch_qcs, :primer2
    remove_column :clone_batch_qcs, :date_send2
    remove_column :clone_batch_qcs, :primer_id
    remove_column :clone_batch_qcs, :primer
    remove_column :clone_batch_qcs, :name
  end
end
