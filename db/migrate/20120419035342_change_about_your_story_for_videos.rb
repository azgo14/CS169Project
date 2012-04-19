class ChangeAboutYourStoryForVideos < ActiveRecord::Migration
  def up
    change_table :videos do |t|
      t.string :title
      t.string :about
      t.remove :qa
    end
  end

  def down
    change_table :videos do |t|
      t.remove :title, :about
      t.string :qa
    end
  end
end
