class AddColumnDateToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :date, :Date
  end
end
