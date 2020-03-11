class AddCbtagToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :cbtag, :string
  end
end
