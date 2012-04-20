class AddNotesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :notes, :text
  end
end
