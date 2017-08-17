class AddPcrColonyIndexToPlasmidBatchQcs < ActiveRecord::Migration
  def change
    add_column :plasmid_batch_qcs, :pcr_colony_id, :integer
  end
end
