class CreateCbCbQc < ActiveRecord::Migration
     def self.up
        create_table :clone_batches_clone_batche_qcs do |t|
           t.belongs_to :clone_batch, index: true
           t.belongs_to :clone_batch_qc, index: true
           add_index(:assays_projects, [:assay_id, :project_id], :unique => true)
        end        
      end

      def self.down
        drop_table :clone_batches_clone_batche_qcs 
      end
end
