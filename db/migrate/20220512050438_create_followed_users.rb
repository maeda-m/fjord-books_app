class CreateFollowedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :followed_users do |t|
      t.belongs_to :follower, null: false, foreign_key: { to_table: :users }
      t.belongs_to :followee, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
