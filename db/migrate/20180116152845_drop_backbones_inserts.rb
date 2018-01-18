class DropBackbonesInserts < ActiveRecord::Migration
  def change
    drop_table :backbones_clones
  end
end
