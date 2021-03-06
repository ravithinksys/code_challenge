# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :member_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
