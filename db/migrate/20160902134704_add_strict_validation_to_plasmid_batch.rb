class AddStrictValidationToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :strict_validation, :integer
  end
end
