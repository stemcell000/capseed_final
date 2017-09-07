class AddDateSend2ToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :date_send2, :date
  end
end
