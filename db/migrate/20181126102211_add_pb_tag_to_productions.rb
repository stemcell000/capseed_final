class AddPbTagToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :pbtag, :string
  end
end
