class ChangeNumberTypeinCloneBatch < ActiveRecord::Migration
  def change
    change_column :clone_batches, :number, :string
  end
end
