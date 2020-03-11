class AddRowIdToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :row_id, :integer
  end
end
