class CreateCloneProject < ActiveRecord::Migration
     def self.up
        create_table :clones_projects do |t|
           t.belongs_to :clone, index: true
           t.belongs_to :project, index: true
        end
      end
 
      def self.down
        drop_table :clones_projects
      end
end
