class CreateUserVirusProductions < ActiveRecord::Migration
  def change
    drop_table :users_virus_productions 
    create_table :users_virus_productions do |t|
      t.belongs_to :virus_production, index: true
      t.belongs_to :user, index: true
      t.timestamps
      t.timestamps null: false
    end
  end
end
