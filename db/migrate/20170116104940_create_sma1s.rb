class CreateSma1s < ActiveRecord::Migration
  def change
    create_table :sma1s do |t|
      t.timestamps null: false
    end
  end
end
