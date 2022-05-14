# frozen_string_literal: true

module CommentDecorator
  def user_name
    user.name.presence || user.email
  end

  def created_at
    l(super, format: :long)
  end
end
