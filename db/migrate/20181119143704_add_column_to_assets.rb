class AddColumnToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :vol_unit_id, :integer
    add_column :assets, :plasmid_batch_id, :integer
    add_column :assets, :volume, :decimal
  end
end
