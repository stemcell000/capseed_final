class AddDateOfThawingToVirusBatches < ActiveRecord::Migration
  def change
    add_column :virus_batches, :date_of_thawing, :date
  end
end
