class CreateVolUnits < ActiveRecord::Migration
  def change
    create_table :vol_units do |t|
      t.timestamps null: false
    end
  end
end
