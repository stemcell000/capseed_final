class CreateTableProductionsProjects < ActiveRecord::Migration
  def up
    create_table :productions_projects do |t|
           t.belongs_to :production, index: true
           t.belongs_to :project, index: true
    end
  end
  def down
    drop_table :productions_projects
  end
    
  
end
