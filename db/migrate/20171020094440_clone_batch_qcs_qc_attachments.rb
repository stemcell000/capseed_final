class CloneBatchQcsQcAttachments < ActiveRecord::Migration
  
     def self.up
        create_table :clone_batch_qcs_qc_attachments do |t|
           t.belongs_to :clone_batch_qc, index: true
           t.belongs_to :qc_attachment, index: true
        end
      end
 
      def self.down
        drop_table :clone_batch_qcs_qc_attachments
      end
      
end
