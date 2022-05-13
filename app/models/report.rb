# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user

  def editable?(operator)
    user_id == operator.id
  end
  alias deletable? editable?
end
