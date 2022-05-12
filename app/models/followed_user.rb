# frozen_string_literal: true

class FollowedUser < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :following_users
  belongs_to :followee, class_name: 'User', inverse_of: :follower_users
end
