# frozen_string_literal: true

module Admin
  class FaqCategoriesController < AdminController
    include Admin::Sortable

    before_action :find_faq_category, only: %i[edit update destroy]

    def index
      @categories = current_scope.includes(:string_translations)
                                 .where(region: current_region)
                                 .order(:position)
    end

    def new
      @category = current_scope.new(region: current_region)
    end

    def create
      @category = current_scope.new(faq_category_params)
      return redirect_to_index if @category.save

      flash_and_render(:new, record: @category)
    end

    def edit; end

    def update
      return redirect_to_index if @category.update(faq_category_params)

      flash_and_render(:edit, record: @category)
    end

    def destroy
      redirect_to_index if @category.destroy
    end

    private

      def find_faq_category
        @category = current_scope.find(params[:id])
      end

      def current_scope
        @current_scope ||= FaqCategory
      end

      def current_sort_path
        sort_admin_region_faq_categories_path
      end

      def faq_category_params
        params.require(:faq_category)
              .permit(
                :name_en,
                :name_zh_tw,
                :region
              )
      end
  end
end
