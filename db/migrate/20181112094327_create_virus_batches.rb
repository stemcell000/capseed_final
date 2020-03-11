class CreateVirusBatches < ActiveRecord::Migration
  def change
    create_table :virus_batches do |t|
      t.string :name
      t.integer :virus_production_id
      t.integer :box_id
      t.integer :row_id
      t.integer :column_id
      t.date :date
      t.float :volume
      t.integer :unit_id

      t.timestamps null: false
    end
  end
end
