class AddStoryTitle < ActiveRecord::Migration
  def change
    add_column :stories, :title, :string
  end
end
