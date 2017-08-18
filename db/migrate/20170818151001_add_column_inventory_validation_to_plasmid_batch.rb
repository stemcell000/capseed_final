class AddColumnInventoryValidationToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :inventory_validation, :integer
  end
end
