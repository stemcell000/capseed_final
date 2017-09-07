class AddSequecingIdToCloneBatchqc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :sequencing_id, :integer
  end
end
