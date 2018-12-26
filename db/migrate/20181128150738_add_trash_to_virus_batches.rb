class AddTrashToVirusBatches < ActiveRecord::Migration
  def change
    add_column :virus_batches, :trash, :boolean, :default => false
  end
end
