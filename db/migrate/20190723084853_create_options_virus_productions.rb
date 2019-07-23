class CreateOptionsVirusProductions < ActiveRecord::Migration
  def change
    drop_table :users_virus_productions
    drop_table :clone_batches_users
    create_table :options_virus_productions do |t|
      t.belongs_to :option, index: true
      t.belongs_to :virus_production, index: true
      t.timestamps
      t.timestamps null: false
    end
  end
end
