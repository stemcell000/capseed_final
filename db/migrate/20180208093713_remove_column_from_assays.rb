class RemoveColumnFromAssays < ActiveRecord::Migration
  def change
    remove_column :assays, :comment 
  end
end
