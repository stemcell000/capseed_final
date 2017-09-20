class AddPrimerIdToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :primer_id, :integer
  end
end
