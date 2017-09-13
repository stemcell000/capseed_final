class AddNumberToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :number, :integer
end
end