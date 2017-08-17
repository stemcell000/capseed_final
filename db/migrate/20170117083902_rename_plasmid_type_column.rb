class RenamePlasmidTypeColumn < ActiveRecord::Migration
  def change
    rename_column :clone_batches, :plasmid_type_id, :type_id
  end
end
