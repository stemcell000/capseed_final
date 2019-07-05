class AddHiddenToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :hidden, :boolean
  end
end
