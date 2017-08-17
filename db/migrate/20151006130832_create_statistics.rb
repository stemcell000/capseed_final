class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.float :value
      t.string :label

      t.timestamps null: false
    end
  end
end
