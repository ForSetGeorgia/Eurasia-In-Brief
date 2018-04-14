class CreateCountryRetinaFlag < ActiveRecord::Migration
  def change
    add_attachment :countries, :flag_image2
  end
end
