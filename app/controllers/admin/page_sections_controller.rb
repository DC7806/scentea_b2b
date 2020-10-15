# frozen_string_literal: true

module Admin
  class PageSectionsController < AdminController
    include Admin::Sortable

    before_action :find_section, only: %i[edit update destroy]
    helper_method :current_page

    def index
      @sections = current_scope.where(region: current_region)
                               .order(:position)
    end

    def new
      @section = current_scope.new(region: current_region)
    end

    def create
      @section = current_scope.new(section_params)
      return redirect_to_index if @section.save

      flash_and_render(:new, record: @section)
    end

    def edit; end

    def update
      return redirect_to_index if @section.update(section_params)

      flash_and_render(:edit, record: @section)
    end

    def destroy
      redirect_to_index if @section.destroy
    end

    private

      def find_section
        @section = current_scope.find(params[:id])
      end

      def current_page
        @current_page ||= Page.find(params[:page_id])
      end

      def current_scope
        @current_scope ||= PageSection
      end

      def current_sort_path
        sort_admin_page_sections_path
      end

      def section_params
        params.require(:section)
              .permit(
                :region
              )
      end
  end
end
