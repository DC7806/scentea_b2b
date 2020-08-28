# frozen_string_literal: true

class PagesController < FrontendController
  def homepage
    @carousels =
      Carousel.where(region: current_user.account.region)
              .includes(:string_translations)
              .order(:position)
  end

  def faq
    @faq_categories =
      FaqCategory.with_faqs
                 .where(region: current_user.account.region)
                 .includes([
                             :string_translations,
                             faqs: %i[string_translations text_translations]
                           ])
                 .order(:position)
  end
end
