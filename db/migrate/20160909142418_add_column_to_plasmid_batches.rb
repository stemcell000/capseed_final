class AddColumnToPlasmidBatches < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :production_id, :integer
  end
end
