# frozen_string_literal: true

module Admin
  class FaqsController < AdminController
    include Admin::Sortable

    before_action :find_faq, only: %i[edit update destroy]
    before_action :category_options, only: %i[new create edit update]

    def index
      associations =
        [:string_translations, faqs: %i[string_translations text_translations]]

      @categories =
        FaqCategory.includes(associations)
                   .where(region: current_region)
                   .order(:position)
    end

    def new
      @faq = current_scope.new(region: current_region)
    end

    def create
      @faq = current_scope.new(faq_params)
      return redirect_to_index if @faq.save

      flash_and_render(:new, record: @faq)
    end

    def edit; end

    def update
      return redirect_to_index if @faq.update(faq_params)

      flash_and_render(:edit, record: @faq)
    end

    def destroy
      redirect_to_index if @faq.destroy
    end

    private

      def find_faq
        @faq = current_scope.find(params[:id])
      end

      def current_scope
        @current_scope ||= Faq
      end

      def current_sort_path
        sort_admin_faqs_path
      end

      def category_options
        @category_options ||=
          FaqCategory.includes(:string_translations)
                     .where(region: current_region).map do |cat|
            [cat.name_zh_tw, cat.id]
          end
      end

      def faq_params
        params.require(:faq)
              .permit(
                :category_id,
                :description_en,
                :description_zh_tw,
                :title_en,
                :title_zh_tw,
                :region
              )
      end
  end
end
