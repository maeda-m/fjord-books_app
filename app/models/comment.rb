# frozen_string_literal: true

class Comment < ApplicationRecord
  COMMENTABLE_TYPES = %w[Book Report].freeze
  delegated_type :commentable, types: COMMENTABLE_TYPES

  belongs_to :user

  validates :commentable_type, inclusion: { in: COMMENTABLE_TYPES }
  validates :content, presence: true

  def author?(operator)
    user_id == operator.id
  end
end
