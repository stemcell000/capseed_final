class AddUserIdToAssay < ActiveRecord::Migration
  def change
    add_column :assays, :user_id, :integer
  end
end
