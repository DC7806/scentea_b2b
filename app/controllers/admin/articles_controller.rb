# frozen_string_literal: true

module Admin
  class ArticlesController < AdminController
    before_action :find_article, only: %i[edit update destroy]
    before_action :category_options, only: %i[new create edit update]

    def index
      associations =
        [:string_translations, category: :string_translations]

      @articles =
        current_scope.includes(associations)
                     .where(region: current_region)
                     .order(published_at: :desc)
    end

    def new
      @article = current_scope.new(region: current_region)
    end

    def create
      @article = current_scope.new(article_params)
      return redirect_to_index if @article.save

      flash_and_render(:new, record: @article)
    end

    def edit; end

    def update
      return redirect_to_index if @article.update(article_params)

      flash_and_render(:edit, record: @article)
    end

    def destroy
      redirect_to_index if @article.destroy
    end

    private

      def find_article
        @article = current_scope.find(params[:id])
      end

      def current_scope
        @current_scope ||= Article
      end

      def category_options
        @category_options ||=
          ArticleCategory.includes(:string_translations)
                         .where(region: current_region).map do |cat|
            [cat.name_zh_tw, cat.id]
          end
      end

      def article_params
        params.require(:article)
              .permit(
                :banner_data,
                :category_id,
                :content_en,
                :content_zh_tw,
                :published,
                :published_at,
                :slug,
                :summary_en,
                :summary_zh_tw,
                :title_en,
                :title_zh_tw,
                :region
              )
      end
  end
end
