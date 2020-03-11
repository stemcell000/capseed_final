class CreateAssayProject < ActiveRecord::Migration
     def self.up
        create_table :assays_projects do |t|
           t.belongs_to :assay, index: true
           t.belongs_to :project, index: true
        end
      end
 
      def self.down
        drop_table :assays_projects
      end
end