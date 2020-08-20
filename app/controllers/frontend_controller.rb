# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_account!

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
