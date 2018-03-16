class AddCountryLocation < ActiveRecord::Migration
  def change
    add_column :countries, :lat, :decimal, :precision => 15, :scale => 12
    add_column :countries, :lon, :decimal, :precision => 15, :scale => 12
  end
end
