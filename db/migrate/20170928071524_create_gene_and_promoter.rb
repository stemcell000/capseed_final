class CreateGeneAndPromoter < ActiveRecord::Migration
     def self.up      
        add_column :genes, :clone_batch_id, :integer
        add_column :promoters, :clone_batch_id, :integer
      end
end
