class DropMessages < ActiveRecord::Migration
  def up
    drop_table :messages
  end

  def down
    create_table :messages do |t|
      t.text :subject
      t.text :message
      t.string :status
      t.string :from_user
      t.string :to_user

      t.timestamps
    end
  end
end
