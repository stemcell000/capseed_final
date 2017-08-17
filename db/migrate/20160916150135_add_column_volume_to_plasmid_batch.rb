class AddColumnVolumeToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :volume, :decimal
    add_column :plasmid_batches, :unit_vol_id, :integer
  end
end
