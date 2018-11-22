class AddVolumeToPlasmidBatchProduction < ActiveRecord::Migration
  def change
    add_column :plasmid_batches_productions, :volume, :decimal
  end
end
