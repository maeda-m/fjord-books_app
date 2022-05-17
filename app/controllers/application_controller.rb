# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      profile_attributes = %i[zipcode address description id]

      permit_param = user_params.permit(:email, :password, :password_confirmation, :current_password, profile_attributes: profile_attributes)
      permit_param[:profile_attributes][:id] = current_user.profile.id

      permit_param
    end
  end
end
