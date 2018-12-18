class CreatePrimerF < ActiveRecord::Migration
  def change
    create_table :primer_fs do |t|
      t.string :name
      t.string :sequence
      t.text :comment
      t.integer :pcr_colony_id
      t.timestamps null: false
    end
  end
end
