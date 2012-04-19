class AddVideoRatings < ActiveRecord::Migration
  def up
    change_table :videos do |t|
      t.integer :likes
    end
    Video.all.each do |vid|
      vid.update_attributes!(:likes => 0)
    end
  end

  def down
    change_table :videos do |t|
      t.remove :likes
    end
  end
end
