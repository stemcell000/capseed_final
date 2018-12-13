class AddBarcodeToPlasmidBatches < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :barcode, :string
  end
end
