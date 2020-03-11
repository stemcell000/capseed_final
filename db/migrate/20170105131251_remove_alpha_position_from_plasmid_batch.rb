class RemoveAlphaPositionFromPlasmidBatch < ActiveRecord::Migration
  def change
    remove_column :plasmid_batches, :alpha_position_id, :string
    remove_column :plasmid_batches, :row_position_id, :string
    change_column :columns, :name, :string
  end
end
