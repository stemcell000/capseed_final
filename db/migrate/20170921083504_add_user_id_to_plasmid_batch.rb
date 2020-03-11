class AddUserIdToPlasmidBatch < ActiveRecord::Migration
  def change
    add_column :plasmid_batches, :user_id, :integer
  end
end
