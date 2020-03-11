class AddBoxIdToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :box_id, :integer
  end
end
