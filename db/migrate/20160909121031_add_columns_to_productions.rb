class AddColumnsToProductions < ActiveRecord::Migration
  
  def up
    add_column :productions, :target, :string
  end
  
  def down
    remove_column :productions, :target, :string
  end
  
end
