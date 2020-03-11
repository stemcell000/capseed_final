class CreateClonesInserts < ActiveRecord::Migration
  def change
    create_table :clones_inserts do |t|
           t.belongs_to :clone, index: true
           t.belongs_to :insert, index: true
     end
  end
end
