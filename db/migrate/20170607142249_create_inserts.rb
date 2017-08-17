class CreateInserts < ActiveRecord::Migration
   def change
    create_table :inserts do |t|
      t.integer :clone_batch_id
      t.string :name
      t.timestamps
    end
 
    add_index :inserts, :clone_batch_id
  end
end
