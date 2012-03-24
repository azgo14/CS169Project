class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.string :youtube_id
      t.datetime :submission_date
      t.references :user
      t.string :name
      t.string :email
      t.integer :age
      #ethnicities?
      t.string :language
      t.string :location
      #additional media?
      t.text :why #Why did you want to tell this story?
      t.text :how #How did telling your story change you?
      t.text :hope #How do you hope hearing your story will change the community?
      t.text :qa
      t.string :status #pending, accepted, or rejected
      t.timestamps
    end
  end

  def down
    drop_table :videos
  end
end
