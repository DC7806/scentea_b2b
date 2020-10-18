# frozen_string_literal: true

module Admin
  class PageSectionsController < AdminController
    include Admin::Sortable

    before_action :find_section, only: %i[edit update destroy]
    before_action :section_style_options, only: %i[new create]
    helper_method :current_page

    def index
      @sections = current_scope.where(
        region: current_region,
        page: current_page
      ).order(:position)
    end

    def new
      @section = current_scope.new
      @section_styles = current_scope.styles.keys
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
        return PageSection if action_name == 'index'

        PageSection.includes(
          contents: %i[string_translations text_translations]
        )
      end

      def current_sort_path
        sort_admin_page_sections_path
      end

      def section_style_options
        @section_style_options ||= current_scope.styles.keys.map do |key|
          [SectionContentStyle.find_by(style: key).name, key]
        end
      end

      def section_params
        params.require(:page_section)
              .permit(
                :style,
                contents_attributes: %i[
                  description_en description_zh_tw
                  id image
                  link_text_en link_text_zh_tw
                  link_url_en link_url_zh_tw
                  subtitle_en subtitle_zh_tw
                  title_en title_zh_tw
                ]
              ).merge(
                {
                  region: current_region,
                  page: current_page
                }
              )
      end
  end
end
