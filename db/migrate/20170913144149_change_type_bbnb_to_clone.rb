class ChangeTypeBbnbToClone < ActiveRecord::Migration
  def up
    change_column :clones, :bbnb, :string
  end

  def down
    change_column :clones, :bbnb, :integer
  end
end
