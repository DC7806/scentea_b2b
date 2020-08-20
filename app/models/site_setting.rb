# frozen_string_literal: true

# == Schema Information
#
# Table name: site_settings
#
#  id                     :bigint           not null, primary key
#  customization_form_url :string           default(""), not null
#  favicon_data           :text
#  logo_data              :text
#  service_email          :string           default(""), not null
#  site_name              :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  fb_id                  :string
#  gtm_id                 :string
#

class SiteSetting < ApplicationRecord
  include SiteFaviconUploader::Attachment(:favicon)
  include SiteLogoUploader::Attachment(:logo)

  extend Mobility
  translates :customization_form_url, type: :string, fallbacks: false
  translates :service_email, type: :string
  translates :site_name, type: :string

  validates :site_name_en,    presence: true
  validates :site_name_zh_tw, presence: true
  validates :customization_form_url_en, format: {
    with: %r{\Ahttps?://}, allow_blank: true
  }
  validates :customization_form_url_zh_tw, format: {
    with: %r{\Ahttps?://}, allow_blank: true
  }
  validates :service_email_en, format: {
    with: Devise.email_regexp
  }
  validates :service_email_zh_tw, format: {
    with: Devise.email_regexp
  }

  validate :one_record_allowed, on: :create

  private

    def one_record_allowed
      return unless self.class.count.positive?

      errors.add(:base, I18n.t('activerecord.errors.messages.one_record_allowed'))
    end
end
