class AddColumnToSequencing < ActiveRecord::Migration
  def change
    add_column :sequencings, :name, :string
  end
end
