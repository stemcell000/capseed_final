class AddActualMemberToUser < ActiveRecord::Migration
  def change
    add_column :users, :actual_member, :boolean, :default => true
  end
end
