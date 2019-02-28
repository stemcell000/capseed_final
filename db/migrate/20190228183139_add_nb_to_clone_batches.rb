class AddNbToCloneBatches < ActiveRecord::Migration
  def change
    add_column :clone_batches, :nb, :integer
  end
end
