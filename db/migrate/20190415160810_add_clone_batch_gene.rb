class AddCloneBatchGene < ActiveRecord::Migration
  def change
    create_table :clone_batches_genes do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :gene, index: true
        end
      end
end
