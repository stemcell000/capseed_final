class RecapVp < ActiveRecord::Migration
  def change
    VirusProduction.all.each do |vp|
      vp.generate_recap
    end
  end
end
