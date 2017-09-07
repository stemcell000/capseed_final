class AddPrimersToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :primer1, :string
    add_column :clone_batch_qcs, :primer2, :string
  end
end
