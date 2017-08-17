class RemoveInsertnbFromClone < ActiveRecord::Migration
  def change
    remove_column :clones, :insertnb
  end
end
