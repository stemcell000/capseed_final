class AddColumnsToAssay < ActiveRecord::Migration
  def up
    add_column :assays, :today_date, :date
    add_column :assays, :percentage, :float, :default => 0
  end
end
