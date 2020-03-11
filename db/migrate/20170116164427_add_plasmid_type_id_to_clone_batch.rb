class AddPlasmidTypeIdToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :plasmid_type_id, :integer
  end
end
