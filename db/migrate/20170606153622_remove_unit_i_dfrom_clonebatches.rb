class RemoveUnitIDfromClonebatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :unit_id
  end
end
