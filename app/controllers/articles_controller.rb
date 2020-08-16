# frozen_string_literal: true

class ArticlesController < FrontendController
  def index
    associations = [
      :string_translations, :text_translations,
      category: :string_translations
    ]

    @articles = articles.published
                        .includes(associations)
                        .order(published_at: :desc)
  end

  def show
    @article = current_scope.find_by(slug: params[:slug])

    @related_articles = @article.related_articles
                                .includes(:string_translations)
                                .order(published_at: :desc)
                                .limit(2)
  end

  private

    def articles
      @q = if params[:q]
        current_scope.ransack(params[:q], region_eq: current_account_region)
      else
        current_scope.ransack(region_eq: current_account_region)
      end

      @q.result
    end

    def current_scope
      @current_scope ||= Article
    end
end
