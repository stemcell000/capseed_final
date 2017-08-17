class CreateClones < ActiveRecord::Migration
  def change
    create_table :clones do |t|
      t.belongs_to :assay, index:true
      t.string :name
      t.integer :bbnb
      t.integer :insertnb
      t.integer :batch_nb
      t.string :primerinsfor
      t.string :primerinsrev
      t.text :comment
      t.text :comment_batch
      t.integer :strict_validation
      t.timestamps null: false
    end
  end
end
