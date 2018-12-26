class AddCloneIdToPrimers < ActiveRecord::Migration
  def change
    add_column :primers, :clone_id, :integer
  end
end
