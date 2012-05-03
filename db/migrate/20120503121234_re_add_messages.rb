class ReAddMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.text :subject
      t.text :message
      t.string :status
      t.integer :from_user
      t.integer :to_user

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
