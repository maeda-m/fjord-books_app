# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @followings = user.followings.with_attached_avatar.order(:id)
    @name = user.name
  end

  def create
    user_id = params[:user_id]
    current_user.follow(user_id)
  rescue ActiveRecord::RecordInvalid
    redirect_to users_url, alert: t('controllers.followings.alert_create')
  else
    redirect_to user_url(user_id), notice: t('controllers.followings.notice_create')
  end

  def destroy
    user_id = params[:user_id]
    current_user.unfollow(user_id)
  rescue ActiveRecord::RecordNotFound
    render file: Rails.root.join('public/404.html'), layout: false, status: :not_found
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to users_url, alert: t('controllers.followings.alert_destroy')
  else
    redirect_to user_url(user_id), notice: t('controllers.followings.notice_destroy')
  end
end
