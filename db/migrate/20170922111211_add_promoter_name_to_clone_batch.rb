class AddPromoterNameToCloneBatch < ActiveRecord::Migration
  def change
    add_column :clone_batches, :promoter_name, :string
  end
end
