class AddInactivationToVirusProduction < ActiveRecord::Migration
  def change
    add_column :dosages, :inactivation, :date
  end
end
