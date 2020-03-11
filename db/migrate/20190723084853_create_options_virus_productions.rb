class CreateOptionsVirusProductions < ActiveRecord::Migration
  def change
    create_table :options_virus_productions do |t|
      t.belongs_to :option, index: true
      t.belongs_to :virus_production, index: true
      t.timestamps
      t.timestamps null: false
    end
  end
end
