class ChangeColumnNameToPlasmidBatch < ActiveRecord::Migration
  def change
    rename_column :plasmid_batches, :unit_vol_id, :vol_unit_id
    add_column :vol_units, :name, :string
  end
end
