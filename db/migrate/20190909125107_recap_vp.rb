class RecapVp < ActiveRecord::Migration
  def change
    Virus.production.all.each do |vp|
      vp.generate_recap
    end
  end
end
