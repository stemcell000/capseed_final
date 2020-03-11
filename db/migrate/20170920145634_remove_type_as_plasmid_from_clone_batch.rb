class RemoveTypeAsPlasmidFromCloneBatch < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :type_as_plasmid
  end
end
