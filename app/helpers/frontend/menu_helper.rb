# frozen_string_literal: true

module Frontend
  module MenuHelper
    def customization_form_url_menu(list_styles: nil)
      return if site_settings.blank?

      locale = current_user.account.domestic? ? :'zh-TW' : :en
      form_url = site_settings.customization_form_url(locale: locale)
      return unless form_url

      content_tag :li, class: list_styles do
        link_to t('.links.customization'),
                form_url,
                target: :_blank,
                rel: 'noopener nofollow'
      end
    end

    def display_locales_menu?
      return true if visitor? || current_user.account.foreign?

      false
    end
  end
end
