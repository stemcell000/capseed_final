class AddQcValidationToPlasmidBatches < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :qc_validation, :boolean, :default => false
  end
end
