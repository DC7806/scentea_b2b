# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_account!
  # before_action :set_locale

  helper_method :article_categories

  private

    def current_account_region
      current_user.account.region
    end

    def authenticate_account!
      case current_user.account.status
      when 'created'
        redirect_to new_account_registration_path
      when 'pending'
        redirect_to complete_account_registration_path
      end
    end

    # def set_locale
    #   I18n.locale = if current_user
    #     params[:locale] || current_user_default_locale
    #   else
    #     extract_locale || I18n.default_locale
    #   end
    # end

    # def extract_locale
    #   browser_lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
    #   parsed_locale = params[:locale] || browser_lang

    #   I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    # end

    # def current_user_default_locale
    #   current_user.account.region == 'domestic' ? 'zh-TW' : 'en'
    # end

    def default_url_options
      { locale: I18n.locale }
    end

    def article_categories
      @article_categories ||=
        ArticleCategory.with_articles
                       .includes(:string_translations)
                       .where(region: current_account_region)
                       .order(:position)
    end
end
