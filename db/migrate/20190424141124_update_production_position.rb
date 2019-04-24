class UpdateProductionPosition < ActiveRecord::Migration
  def change
    Production.where("last_step < ?", 3 ).order(:id).each.with_index(1) do |production, index|
        production.update_column :position, index
    end
  end
end
