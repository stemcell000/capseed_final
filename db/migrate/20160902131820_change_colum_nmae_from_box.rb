class ChangeColumNmaeFromBox < ActiveRecord::Migration
  def change
    rename_column :boxes, :alias, :name
  end
end
