class CreateSequencings < ActiveRecord::Migration
  def change
    create_table :sequencings do |t|

      t.timestamps null: false
    end
  end
end
