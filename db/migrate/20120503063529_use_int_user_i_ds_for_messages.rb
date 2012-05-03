class UseIntUserIDsForMessages < ActiveRecord::Migration
  def up
    change_table :messages do |t|
      t.change :from_user, :integer
      t.change :to_user, :integer
    end
  end

  def down
    change_table :messages do |t|
      t.change :from_user, :string
      t.change :to_user, :string
    end
  end
end
