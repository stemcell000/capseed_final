class CreateGene < ActiveRecord::Migration
  def self.up
    create_table :genes do |t|
      t.string :name
    end
  end
end
