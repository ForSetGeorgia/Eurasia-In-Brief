class AddCountryMapZoom < ActiveRecord::Migration
  def change
    add_column :countries, :map_zoom_level, :integer, default: 13
  end
end
