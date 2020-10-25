# frozen_string_literal: true

class PagesController < FrontendController
  before_action :page_content, only: %i[homepage about affiliation]

  def about; end

  def affiliation; end

  def faq
    @faq_categories =
      FaqCategory.with_faqs
                 .where(region: current_account_region)
                 .includes([
                             :string_translations,
                             faqs: %i[string_translations text_translations]
                           ])
                 .order(:position)
  end

  def homepage
    @carousels =
      Carousel.where(region: current_account_region)
              .includes(:string_translations)
              .order(:position)
  end

  private

    def page_content
      @page_content =
        Rails.cache.read(
          "page_content_#{current_account_region}_#{action_name}_#{I18n.locale.to_s.underscore}"
        )
    end
end
