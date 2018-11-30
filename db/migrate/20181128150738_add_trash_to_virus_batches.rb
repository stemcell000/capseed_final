class AddTrashToVirusBatches < ActiveRecord::Migration
  def change
    add_column :virus_batches, :trash, :boolean, :default => true
  end
end
