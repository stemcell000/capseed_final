class AddColumnToProduction < ActiveRecord::Migration
 def up
    add_column :productions, :today_date, :date
    add_column :productions, :percentage, :float, :default => 0
  end
end
