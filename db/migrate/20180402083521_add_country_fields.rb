class AddCountryFields < ActiveRecord::Migration
  def change
    add_column :countries, :freedom_house_index, :string
    add_column :countries, :freedom_house_url, :string
    add_column :countries, :ti_index_score, :integer
    add_column :countries, :ti_index_rank, :integer
    add_column :countries, :ti_url, :string
  end
end
