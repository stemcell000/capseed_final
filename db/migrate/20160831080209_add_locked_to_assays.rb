class AddLockedToAssays < ActiveRecord::Migration
  def change
    add_column :assays, :locked, :boolean
  end
end
