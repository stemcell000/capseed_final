class AddColumnSma1IdToPlasmidBatchQc < ActiveRecord::Migration
  def change
    add_column :plasmid_batch_qcs, :sma1_id, :integer
  end
end
