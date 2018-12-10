class AddColumnToDosage < ActiveRecord::Migration
  def change
    add_column :dosages, :comment, :text
  end
end
