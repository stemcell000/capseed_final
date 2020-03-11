class AddNumberToPlamsidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :number, :string
  end
end
