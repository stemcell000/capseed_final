class SetUpdatePbNameAtId < ActiveRecord::Migration
   def self.up
    PlasmidBatch.update_all("name=id")
  end

  def self.down
  end
end
