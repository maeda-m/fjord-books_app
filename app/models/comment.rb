# frozen_string_literal: true

class Comment < ApplicationRecord
  delegated_type :commentable, types: %w[Book Report]
  belongs_to :user

  def author?(operator)
    user_id == operator.id
  end
end
