class AddUniqIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :followed_users, [:follower_id, :followee_id], unique: true
  end
end
