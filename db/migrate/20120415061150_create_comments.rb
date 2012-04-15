class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :user
      t.references :video
      t.string :content
      t.string :status
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
