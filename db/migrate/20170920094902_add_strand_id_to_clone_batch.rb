class AddStrandIdToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :strand_id, :integer
  end
end
