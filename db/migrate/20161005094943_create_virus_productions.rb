class CreateVirusProductions < ActiveRecord::Migration
  def change
    create_table :virus_productions do |t|
      t.date :date_order
      t.date :date_production
      t.integer :user_id
      t.integer :plate_nb
      t.decimal :vol
      t.integer :sterility
      t.integer :plate_id
      t.decimal :titer_atcc
      t.decimal :titer
      t.decimal :titer_to_atcc
      t.text :comment
      t.integer :gel_prot
      t.boolean :invoice
      t.boolean :batch_end
      t.boolean :l2
      t.text :hek_result

      t.timestamps null: false
    end
  end
end
