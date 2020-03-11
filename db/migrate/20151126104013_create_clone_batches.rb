class CreateCloneBatches < ActiveRecord::Migration
  def change
    create_table :clone_batches do |t|
      t.belongs_to :clone, index:true
      t.belongs_to :unit, index:true
      t.belongs_to :target, index:true
      t.string :name
      t.string :temp_name
      t.text :comment
      t.boolean :qc_validation, default: false
      t.integer :strict_validation, :default =>0
      t.integer :plasmid_validation, :default =>0
      t.string :strand_as_plasmid
      t.date :date_as_plasmid
      t.decimal :glyc_stock_as_plasmid
      t.string :glyc_stock_box_as_plasmid
      t.string :type_as_plasmid
      t.text :comment_as_plasmid
      t.string :promoter_as_plasmid
      t.string :gene_as_plasmid
      t.timestamps null: false
    end
  end
  
  def down
    drop_table :clone_batches
  end
end
