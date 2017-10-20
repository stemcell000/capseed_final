class AddNameToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :name, :string
  end
end
