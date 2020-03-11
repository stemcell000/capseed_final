class AddVolumeToPlasmidBatchProduction < ActiveRecord::Migration
  def change
    add_column :plasmid_batches_productions, :volume, :decimal, :default => 0
  end
end
