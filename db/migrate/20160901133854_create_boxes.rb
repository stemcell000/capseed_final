class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.string :alias

      t.timestamps null: false
    end
  end
end
