class CreateTableSequencing < ActiveRecord::Migration
  def change
    create_table :table_sequencings do |t|
      t.string :name
    end
  end
end
