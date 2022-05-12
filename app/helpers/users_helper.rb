# frozen_string_literal: true

module UsersHelper
  def render_avatar(avatar, width: nil, height: nil)
    return unless avatar.attached?

    size = [width, height]
    alt = User.human_attribute_name(:avatar)

    image = if size.all?(&:nil?)
              rails_storage_proxy_url(avatar)
            else
              avatar.variant(resize_to_limit: size)
            end

    css = [controller_name, action_name].join('-')
    content_tag :figure, class: css do
      image_tag image, alt: alt
    end
  end
end
