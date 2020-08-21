# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout 'frontend'

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  helper_method :article_categories
  helper_method :site_settings

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up, keys: %i[first_name last_name]
      )
    end

  private

    def set_locale
      I18n.locale = params[:locale] || current_user_default_locale ||
                    extract_locale || I18n.default_locale
    end

    def extract_locale
      browser_lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)[0]
      parsed_locale = params[:locale] || browser_lang

      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def current_user_default_locale
      return nil unless current_user

      current_user.account.region == 'domestic' ? 'zh-TW' : 'en'
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def flash_success
      flash[:notice] =
        t("controller.actions.#{action_name}_success",
          resource: current_scope.model_name.human)
    end

    def site_settings
      @site_settings ||= SiteSetting.first
    end

    def current_scope
      raise NotImplementedError
    end

    def article_categories
      @article_categories ||=
        ArticleCategory.with_articles
                       .includes(:string_translations)
                       .where(region: current_account_region)
                       .order(:position)
    end

    def current_account_region
      current_user.account.region
    end
end
