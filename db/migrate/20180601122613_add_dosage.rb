class AddDosage < ActiveRecord::Migration
  def change
         create_table :dosages do |t|
           t.decimal :titer
           t.decimal :titer_atcc
           t.decimal :titer_to_atcc
           t.integer :virus_production_id
           t.integer :user_id
           t.date :date
        end
  end
end
