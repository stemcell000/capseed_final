class ModifyLastStepFromProduction < ActiveRecord::Migration
    def up
    add_column :productions, :last_step, :integer, :default => 0
  end
  
  def down
    remove_column :productions, :last_step
  end
end
