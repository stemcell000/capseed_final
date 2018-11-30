class ChangeUnitsToVirusBatches < ActiveRecord::Migration
  def change
    remove_column :virus_batches, :unit_id
    add_column :virus_batches, :vol_unit_id, :integer
  end
end
