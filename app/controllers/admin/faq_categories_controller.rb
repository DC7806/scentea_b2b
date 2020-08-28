# frozen_string_literal: true

module Admin
  class FaqCategoriesController < CategoriesController
    private

      def current_scope
        @current_scope ||= FaqCategory
      end

      def current_sort_path
        sort_admin_faq_categories_path
      end

      def current_category_param
        :faq_category
      end
  end
end
