class AddNameToFormat < ActiveRecord::Migration
  def change
    add_column :formats, :name, :string
  end
end
