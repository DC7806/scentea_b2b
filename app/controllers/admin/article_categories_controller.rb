# frozen_string_literal: true

module Admin
  class ArticleCategoriesController < CategoriesController
    private

      def current_scope
        @current_scope ||= ArticleCategory
      end

      def current_sort_path
        sort_admin_region_article_categories_path
      end

      def current_category_param
        :article_category
      end
  end
end
