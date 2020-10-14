# frozen_string_literal: true

module Admin
  class PagesController < AdminController
    def index
      @pages = Page.includes(:string_translations)
                   .order(:id)
    end
  end
end
