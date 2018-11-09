class CreatOriginTable < ActiveRecord::Migration
  def change
    create_table :origins do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
