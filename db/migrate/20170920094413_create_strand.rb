class CreateStrand < ActiveRecord::Migration
  def change
    create_table :strands do |t|
      t.string :name
    end
  end
end
