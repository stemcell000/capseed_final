class CreateOptions < ActiveRecord::Migration
  def change
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
