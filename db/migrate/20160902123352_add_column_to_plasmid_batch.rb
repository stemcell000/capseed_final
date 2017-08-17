class AddColumnToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :alpha_position_id, :integer
    add_column :plasmid_batches, :row_position_id, :integer
  end
end
