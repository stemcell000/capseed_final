class AddWithdrawVolumeToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :wdvol, :decimal
  end
end
