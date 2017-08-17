class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.string :name
      t.boolean :display
      t.integer :step, :default =>0
      t.text :comment
      t.integer :row_order

      t.timestamps null: false
    end
  end
end
