class AddPcrColonyIdToCloneBatchQc < ActiveRecord::Migration
  def change
    add_column :clone_batch_qcs, :pcr_colony_id, :integer
  end
end
