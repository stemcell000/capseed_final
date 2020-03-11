class AddInventoryValidationToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :inventory_validation, :integer, :default=>0
  end
end
