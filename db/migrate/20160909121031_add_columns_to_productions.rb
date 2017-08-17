class AddColumnsToProductions < ActiveRecord::Migration
  def up
    add_column :productions, :date_order, :date
    add_column :productions, :date_production, :string
    add_column :productions, :clone_batch_id, :integer
    add_column :productions, :user_id, :integer
  end
  def down
    remove_column :productions, :date_order, :date
    remove_column :productions, :date_production, :string
    remove_column :productions, :clone_batch_id, :integer
    remove_column :productions, :user_id, :integer
  end
end
