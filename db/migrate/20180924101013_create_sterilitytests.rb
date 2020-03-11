class CreateSterilitytests < ActiveRecord::Migration
  def change
    create_table :sterilitytests do |t|
      t.integer :sterility
      t.date :date
      t.integer :virus_production_id
      t.timestamps null: false
    end
  end
end
