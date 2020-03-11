class CreatePrimers < ActiveRecord::Migration
  def change
    create_table :primers do |t|
      t.string :name
      t.string :sequence
      t.text :comment
      t.timestamps null: false
    end
  end
end
