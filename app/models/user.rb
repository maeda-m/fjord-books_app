# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  has_one :profile, dependent: :destroy

  after_create { create_profile! }
  accepts_nested_attributes_for :profile
end
