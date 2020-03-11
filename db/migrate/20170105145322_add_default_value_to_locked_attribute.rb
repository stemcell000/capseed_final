class AddDefaultValueToLockedAttribute < ActiveRecord::Migration
  def up
  change_column :assays, :locked, :boolean, :default => false
end

def down
  change_column :assays, :locked, :boolean, :default => nil
end
end
