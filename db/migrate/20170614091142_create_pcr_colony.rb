class CreatePcrColony < ActiveRecord::Migration
  def change
    create_table :pcr_colonies do |t|
      t.string :name
    end
  end
end
