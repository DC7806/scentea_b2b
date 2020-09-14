# frozen_string_literal: true

FactoryBot.define do
  factory :site_setting do
    customization_form_url_en { Faker::Internet.url }
    customization_form_url_zh_tw { Faker::Internet.url }
    site_name_en { Faker::Name.name }
    site_name_zh_tw { Faker::Name.name }
    service_email_en { Faker::Internet.email }
    service_email_zh_tw { Faker::Internet.email }
  end
end
