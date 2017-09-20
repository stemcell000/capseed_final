class AddPromoterIdToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :promoter_id, :integer
  end
end
