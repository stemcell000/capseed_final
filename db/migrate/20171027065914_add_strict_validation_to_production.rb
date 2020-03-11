class AddStrictValidationToProduction < ActiveRecord::Migration
  def change
    add_column :productions, :strict_validation, :integer
  end
end
