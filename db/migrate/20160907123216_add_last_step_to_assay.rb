class AddLastStepToAssay < ActiveRecord::Migration
  def up
    add_column :assays, :last_step, :integer, :default => 0
  end
  
  def down
    remove_column :assays, :last_step
  end
end
