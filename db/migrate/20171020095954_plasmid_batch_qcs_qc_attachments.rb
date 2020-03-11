class PlasmidBatchQcsQcAttachments < ActiveRecord::Migration
       def self.up
        create_table :plasmid_batch_qcs_qc_attachments do |t|
           t.belongs_to :plasmid_batch_qc, index: true
           t.belongs_to :qc_attachment, index: true
        end
      end
 
      def self.down
        drop_table :plasmid_batch_qcs_qc_attachments
      end
end
