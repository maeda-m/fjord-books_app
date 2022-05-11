# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.includes(:profile).order(:email).page(params[:page])
  end

  def show
    @user = User.includes(:profile).find(params[:id])
  end
end
