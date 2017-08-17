class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.integer :name

      t.timestamps null: false
    end
  end
end
