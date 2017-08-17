class AddColumnToPlasmidBatchQc < ActiveRecord::Migration
  def change
    add_column :plasmid_batch_qcs, :conclusion, :boolean
  end
end
