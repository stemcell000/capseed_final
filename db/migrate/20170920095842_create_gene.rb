class CreateGene < ActiveRecord::Migration
  def self.up
    create_table :genes do |t|
      t.string :name
    end

        create_table :clone_batches_genes do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :gene, index: true
        end
      end
 
      def self.down
        drop_table :clone_batches_genes
      end
end
