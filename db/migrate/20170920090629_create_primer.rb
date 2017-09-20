class CreatePrimer < ActiveRecord::Migration
  def change
    create_table :primers do |t|
      t.string :name
      t.string :number
    end
  end
end
