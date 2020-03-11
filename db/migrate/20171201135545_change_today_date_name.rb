class ChangeTodayDateName < ActiveRecord::Migration
  def change
    rename_column :productions, :today_date, :order_date
  end
end
