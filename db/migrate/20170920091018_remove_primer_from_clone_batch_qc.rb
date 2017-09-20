class RemovePrimerFromCloneBatchQc < ActiveRecord::Migration
  def change
    remove_column :clone_batch_qcs, :primer_name
    remove_column :clone_batch_qcs, :primer_nb
  end
end
