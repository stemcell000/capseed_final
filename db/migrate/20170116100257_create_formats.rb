class CreateFormats < ActiveRecord::Migration
  def change
    create_table :formats do |t|

      t.timestamps null: false
    end
  end
end
