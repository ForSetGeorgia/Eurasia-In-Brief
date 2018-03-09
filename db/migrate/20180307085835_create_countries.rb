class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :slug

      t.timestamps null: false
    end

    Country.create_translation_table! name: :string, slug: :string, leader: :string

    add_index :countries, :slug, unique: true
    add_index :country_translations, :slug
    add_index :country_translations, :name
  end
end
