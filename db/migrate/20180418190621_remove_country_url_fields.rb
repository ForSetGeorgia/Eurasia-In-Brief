class RemoveCountryUrlFields < ActiveRecord::Migration
  def up
    remove_column :countries, :freedom_house_url, :string
    remove_column :countries, :ti_url, :string
  end

  def down
    add_column :countries, :freedom_house_url, :string
    add_column :countries, :ti_url, :string
  end
end
