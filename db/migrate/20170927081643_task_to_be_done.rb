class TaskToBeDone < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :strand_as_plasmid
    remove_column :clone_batches, :gene_as_plasmid
    remove_column :clone_batches, :promoter_as_plasmid
  end
end
