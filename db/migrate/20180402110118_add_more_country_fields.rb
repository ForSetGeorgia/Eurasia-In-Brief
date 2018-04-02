class AddMoreCountryFields < ActiveRecord::Migration
  def change
    add_column :countries, :area, :integer
    add_column :countries, :population, :integer
    add_column :countries, :gdp, :integer
  end
end
