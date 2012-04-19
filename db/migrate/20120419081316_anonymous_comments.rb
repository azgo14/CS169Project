class AnonymousComments < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.boolean :anonymous
    end
  end

  def down
    change_table :comments do |t|
      t.remove :anonymous
    end
  end
end
