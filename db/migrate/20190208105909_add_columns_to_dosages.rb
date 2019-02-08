class AddColumnsToDosages < ActiveRecord::Migration
  def change
    add_column :dosages, :inactivation_atcc, :date
    add_column :dosages, :inactivation_standard, :date
    add_column :dosages, :accepted, :boolean
  end
end
