class AddColumnLockedToProduction < ActiveRecord::Migration
  def up
    add_column :productions, :locked, :boolean, :default => false 
  end
end
