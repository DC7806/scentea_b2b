# frozen_string_literal: true

module Admin
  class CarouselsController < AdminController
    include Admin::Sortable

    before_action :find_carousel, only: %i[edit update destroy]

    def index
      @carousels =
        current_scope.includes(:string_translations)
                     .where(region: current_region)
                     .order(:position)
    end

    def new
      @carousel = current_scope.new(region: current_region)
    end

    def create
      @carousel = current_scope.new(carousel_params)
      return redirect_to_index if @carousel.save

      flash_and_render(:new, record: @carousel)
    end

    def edit; end

    def update
      return redirect_to_index if @carousel.update(carousel_params)

      flash_and_render(:edit, record: @carousel)
    end

    def destroy
      redirect_to_index if @carousel.destroy
    end

    private

      def find_carousel
        @carousel = current_scope.find(params[:id])
      end

      def current_scope
        @current_scope ||= Carousel
      end

      def current_sort_path
        sort_admin_carousels_path
      end

      def carousel_params
        params.require(:carousel)
              .permit(
                :button_text_en,
                :button_text_zh_tw,
                :button_url,
                :image,
                :subtitle_en,
                :subtitle_zh_tw,
                :region,
                :title_en,
                :title_zh_tw
              )
      end
  end
end
