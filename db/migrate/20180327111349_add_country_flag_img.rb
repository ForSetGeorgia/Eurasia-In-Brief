class AddCountryFlagImg < ActiveRecord::Migration
  def change
    add_attachment :countries, :flag_image
  end
end
