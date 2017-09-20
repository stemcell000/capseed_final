class AddGeneIdToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :gene_id, :integer
  end
end
