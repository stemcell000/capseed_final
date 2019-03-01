class CreateCloneBatchesPromoters < ActiveRecord::Migration
     def self.up
        create_table :clone_batches_promoters do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :promoter, index: true
        end
      end
 
      def self.down
        drop_table :clone_batches_promoters
      end
end
