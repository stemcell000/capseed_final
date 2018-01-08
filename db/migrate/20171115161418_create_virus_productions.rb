class CreateVirusProductions < ActiveRecord::Migration
  def change
    create_table :virus_productions do |t|
      t.belongs_to :production, index:true
      t.belongs_to :user, index:true
      t.belongs_to :vol_unit, index:true
      t.string :name
      t.integer :plate_nb
      t.decimal :vol
      t.boolean :sterility
      t.text :plate_id
      t.decimal :titer
      t.decimal :titer_atcc
      t.decimal :titer_to_atcc
      t.text :comment
      t.string :gel_prot
      t.boolean :invoice
      t.string :batch_end
      t.boolean :l2
      t.text :hek_result
      t.string :animal
      t.timestamps null: false
    end
  end
end
