class AddBacordeToVirusBatches < ActiveRecord::Migration
  def change
    add_column :virus_batches, :barcode, :string
  end
end
