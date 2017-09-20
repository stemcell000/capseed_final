class CreatePromoter < ActiveRecord::Migration
  def change
    create_table :promoters do |t|
      t.string :name
    end
  end
end
