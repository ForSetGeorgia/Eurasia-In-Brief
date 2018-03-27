class AddCountryLeaderPhoto < ActiveRecord::Migration
  def change
    add_attachment :countries, :leader_image
  end
end
