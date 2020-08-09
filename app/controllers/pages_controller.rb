# frozen_string_literal: true

class PagesController < ApplicationController
  def homepage; end

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
