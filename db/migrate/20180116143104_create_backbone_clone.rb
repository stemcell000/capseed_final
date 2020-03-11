class CreateBackboneClone < ActiveRecord::Migration
   def change
    create_table :backbones_clones do |t|
           t.belongs_to :clone, index: true
           t.belongs_to :backbones, index: true
     end
    end
  end
