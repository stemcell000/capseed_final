class CreateCloneEnzyme < ActiveRecord::Migration
   def self.up
    create_table :clones_enzymes do |t|
      t.references :clone, null:false
      t.references :enzyme, null:false
    end
  end
  def self.down
    drop_table :clones_enzymes
  end
end

