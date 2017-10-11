class AddCloneBatchIdToFoo < ActiveRecord::Migration
  def change
    add_column :foos, :clone_batch_id, :integer
  end
end
