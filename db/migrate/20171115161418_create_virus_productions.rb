class CreateVirusProductions < ActiveRecord::Migration
  def change
    create_table :virus_productions do |t|
      t.belongs_to :production, index:true
      t.belongs_to :user, index:true
      t.belongs_to :vol_unit, index:true
      t.date :date_order
      t.date :date_production
      t.integer :plate_nb
      t.decimal :vol
      t.boolean :sterility
      t.text :plate_id
      t.decimal :titer
      t.decimal :titer_atcc
      t.decimal :titer_to_atcc
      t.text :comment
      t.integer :get_prot
      t.boolean :invoice
      t.string :batch_end
      t.boolean :l2
      t.text :hek_result
    end
  end
end
