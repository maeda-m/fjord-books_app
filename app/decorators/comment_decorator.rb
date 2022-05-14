# frozen_string_literal: true

module CommentDecorator
  def user_name
    return t('comments.canceled_user') unless user

    user.name.presence || user.email
  end

  def created_at
    l(super, format: :long)
  end
end
