class CreateEnzymes < ActiveRecord::Migration
  def change
    create_table :enzymes do |t|
      t.string :name
      t.string :category

      t.timestamps null: false
    end
  end
end
