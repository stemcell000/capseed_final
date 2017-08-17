class RemoveConcentrationfromClonebatches < ActiveRecord::Migration
  def change
    remove_column :clone_batches, :glyc_stock_as_plasmid
  end
end
