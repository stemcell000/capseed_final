class CreateTablePlasmidBatchProduction < ActiveRecord::Migration
  def self.up
        create_table :plasmid_batches_productions do |t|
           t.belongs_to :plasmid_batch, index: true
           t.belongs_to :production, index: true
        end
      end
 
      def self.down
        drop_table :plasmid_batchess_productions
      end
end
