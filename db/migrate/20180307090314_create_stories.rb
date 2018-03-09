class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :locale
      t.text :content
      t.string :link
      t.references :time_period, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :stories, :locale
  end
end
