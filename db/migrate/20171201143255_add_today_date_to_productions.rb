class AddTodayDateToProductions < ActiveRecord::Migration
  def change
    add_column :productions, :today_date, :date
  end
end
