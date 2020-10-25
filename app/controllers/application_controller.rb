# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LocaleExtractable

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
      I18n.locale = params[:locale] || extract_locale
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
      current_user.region
    end
end
