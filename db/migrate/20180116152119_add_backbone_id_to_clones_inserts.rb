class AddBackboneIdToClonesInserts < ActiveRecord::Migration
  def change
    add_column :clones_inserts, :backbone_id, :integer  
  end
end
