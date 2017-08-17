class AddNameToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :name, :string
  end
end
