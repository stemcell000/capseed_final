class CreateVirusProductions < ActiveRecord::Migration
  def change
    create_table :virus_productions do |t|
      t.belongs_to :production, index:true
      t.belongs_to :user, index:true
      t.belongs_to :vol_unit, index:true
      t.decimal :vol
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
