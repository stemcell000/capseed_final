class AddColmunIdToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :column_id, :integer
  end
end
