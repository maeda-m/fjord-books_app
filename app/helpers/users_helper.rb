# frozen_string_literal: true

module UsersHelper
  def render_avatar(avatar, width:, height:)
    return unless avatar.attached?

    alt = User.human_attribute_name(:avatar)
    content_tag :figure do
      image_tag avatar.variant(resize_to_limit: [width, height]), alt: alt
    end
  end
end
