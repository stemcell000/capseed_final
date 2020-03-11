class CreatePlasmidBatches < ActiveRecord::Migration
  def change
    create_table :plasmid_batches do |t|
    t.belongs_to :clone_batch, index:true
    t.belongs_to :unit, index:true
    t.string :name
    t.string :format
    t.decimal :concentration
    t.text :comment
      t.timestamps null: false
    end
    
   def down
     drop_table :plasmid_batches
   end 
    
  end
end
