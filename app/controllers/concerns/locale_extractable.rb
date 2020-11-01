# frozen_string_literal: true

module LocaleExtractable
  extend ActiveSupport::Concern

  included do
    def extract_locale
      browser_lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
      parsed_locale = params[:locale] || browser_lang

      return parsed_locale if I18n.available_locales.map(&:to_s).include?(parsed_locale)

      I18n.default_locale
    end
  end
end
