class RemovePromoterNameFromCloneBatch < ActiveRecord::Migration
  def change
   remove_column :clone_batches, :promoter_name
  end
end
