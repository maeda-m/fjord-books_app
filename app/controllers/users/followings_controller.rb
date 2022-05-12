# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @followings = user.followings.with_attached_avatar.order(:id)
    @name = user.name
  end

  def create
    user_id = params[:user_id]
    following_user = current_user.following_users.build(followee_id: user_id)

    notice = if following_user.save
               t('controllers.followings.notice_create')
             else
               following_user.errors.full_messages.join(' ')
             end

    redirect_to user_url(user_id), notice: notice
  end

  def destroy
    user_id = params[:user_id]
    following_user = current_user.following_users.find_by(followee_id: user_id)
    following_user.try(:destroy)

    redirect_to user_url(user_id), notice: t('controllers.followings.notice_destroy')
  end
end
