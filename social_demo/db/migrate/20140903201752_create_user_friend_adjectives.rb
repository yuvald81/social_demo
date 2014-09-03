class CreateUserFriendAdjectives < ActiveRecord::Migration
  def change
    create_table :user_friend_adjectives do |t|
      t.integer :user_id
      t.string :friend_id
      t.integer :adjective_id

      t.timestamps
    end
  end
end
