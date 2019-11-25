class RemoveTubes1 < ActiveRecord::Migration
  def change
     a = [*759..918] - [783, 784, 798, 800, 851, 880, 881]
    for i in a
     vp = VirusProduction.find[i]
      vp.virus_batches.each do |vb|
        vb.update_columns(:trash => true)
      end
    end
    
  end
end
