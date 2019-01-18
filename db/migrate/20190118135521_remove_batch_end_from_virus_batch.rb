class RemoveBatchEndFromVirusBatch < ActiveRecord::Migration
  def change
    remove_column :virus_productions, :batch_end
  end
end
