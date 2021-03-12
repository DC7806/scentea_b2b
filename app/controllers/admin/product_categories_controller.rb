# frozen_string_literal: true

module Admin
  class ProductCategoriesController < AdminController
    include Admin::Sortable

    before_action :find_category, only: %i[edit update destroy]
    before_action :parent_category_options, only: %i[edit update]

    def index
      @categories = current_scope.includes(:string_translations)
                                 .where(region: current_region)
                                 .order(:position)
                                 .arrange
    end

    def new
      parent_id = params[:parent_id]

      @category =
        if parent_id.present?
          current_scope.children_of(parent_id)
                       .new(region: current_region)
        else
          current_scope.new(region: current_region)
        end
    end

    def create
      @category = current_scope.new(category_params)

      return redirect_to_index if @category.save

      flash_and_render(:new, record: @category)
    end

    def edit; end

    def update
      return redirect_to_index if @category.update(category_params)

      flash_and_render(:edit, record: @category)
    end

    def destroy
      redirect_to_index if @category.destroy
    rescue Ancestry::AncestryException => e
      flash[:alert] = e.message
      redirect_to admin_product_categories_path
    end

    private

      def current_scope
        @current_scope ||= ProductCategory
      end

      def find_category
        @category = current_scope.find(params[:id])
      end

      def current_sort_path
        sort_admin_product_categories_path
      end

      def parent_category_options
        @parent_category_options =
          ProductCategory.includes(:string_translations)
                         .where(region: current_region)
                         .where.not(id: params[:id])
                         .roots
                         .order(:position)
      end

      def category_params
        params.require(:product_category)
              .permit(
                :name_en,
                :name_zh_tw,
                :parent_id,
                :region
              )
      end
  end
end
