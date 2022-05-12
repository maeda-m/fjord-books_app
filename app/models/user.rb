# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :following_users, class_name: 'FollowedUser', foreign_key: :follower_id, inverse_of: :follower, dependent: :destroy
  has_many :follower_users, class_name: 'FollowedUser', foreign_key: :followee_id, inverse_of: :followee, dependent: :destroy

  has_many :followings, through: :following_users, source: :followee
  has_many :followers, through: :follower_users, source: :follower

  def followed?(user)
    following_ids.include?(user.id)
  end
end
