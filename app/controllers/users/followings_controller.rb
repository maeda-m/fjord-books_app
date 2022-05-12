# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @followings = user.followings.with_attached_avatar.order(:id)
    @name = user.name
  end

  def create
    user_id = params[:user_id]
    current_user.following_users.create(followee_id: user_id)

    redirect_to user_url(user_id), notice: t('controllers.followings.notice_create')
  end

  def destroy
    user_id = params[:user_id]
    current_user.following_users.where(followee_id: user_id).first.destroy

    redirect_to user_url(user_id), notice: t('controllers.followings.notice_destroy')
  end
end
