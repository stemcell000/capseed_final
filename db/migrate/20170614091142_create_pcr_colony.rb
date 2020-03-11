class CreatePcrColony < ActiveRecord::Migration
  def change
    create_table :pcr_colonies do |t|
      t.string :name
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :pcr_colonies
  end
end
