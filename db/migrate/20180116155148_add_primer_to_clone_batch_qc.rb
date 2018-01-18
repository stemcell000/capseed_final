class AddPrimerToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :primer, :string
  end
end
