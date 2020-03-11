class CreateCmeth < ActiveRecord::Migration
  def change
    create_table :cmeths do |t|
      t.string :name
    end
  end
end
