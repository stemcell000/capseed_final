class AddColumnLockedToProduction < ActiveRecord::Migration
  def up
    add_column :productions, :locked, :boolean, :default => false 
    
     create_table :options do |t|
      t.integer :user_id
      t.boolean :display_hidden_virus
      t.boolean :display_all_virus
      t.boolean :display_all_clone_batch
      t.boolean :display_hidden_clone_batch
      t.timestamps null: false
    end
  end
end
