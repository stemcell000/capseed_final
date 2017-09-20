class CreateGene < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.string :name
    end
  end
end
