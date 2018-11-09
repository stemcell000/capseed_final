class RemoveOriginAsPlasmid < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :origin_as_plasmid
  end
end
