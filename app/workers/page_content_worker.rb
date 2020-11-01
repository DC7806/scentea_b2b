# frozen_string_literal: true

class PageContentWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(region, page_id)
    page = Page.find(page_id)

    build_page_content(region, page)
  end

  private

    def build_page_content(region, page)
      locales = region == 'domestic' ? [I18n.default_locale] : I18n.available_locales

      locales.each do |locale|
        page_content =
          page.sections.public_send(region).order(:position).map.with_index do |section, _index|
            ActionController::Base.new.render_to_string(
              partial: "section_contents/#{section.style}",
              locals: { contents: section.contents, locale: locale },
              layout: false
            )
          end.join

        Rails.cache.write(
          "page_content_#{region}_#{page.name_en}_#{locale.to_s.underscore}",
          page_content
        )
      end
    end
end
