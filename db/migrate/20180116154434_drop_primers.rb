class DropPrimers < ActiveRecord::Migration
  def change
    drop_table :primers
  end
end
