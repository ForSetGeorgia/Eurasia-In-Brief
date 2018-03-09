class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|
      t.string :slug
      t.integer :order, default: 1
      t.boolean :is_published, default: false

      t.timestamps null: false
    end

    TimePeriod.create_translation_table! label: :string, slug: :string

    add_index :time_periods, :slug, unique: true
    add_index :time_periods, :order
    add_index :time_periods, :is_published
    add_index :time_period_translations, :slug
    add_index :time_period_translations, :label
  end
end
