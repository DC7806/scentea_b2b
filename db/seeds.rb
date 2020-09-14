# frozen_string_literal: true

if SiteSetting.count.zero?
  SiteSetting.create(
    fb_id: 'scenteataiwan',
    site_name_en: 'SCENTEA B2B',
    site_name_zh_tw: 'SCENTEA B2B',
    service_email_en: 'service@scentea.co',
    service_email_zh_tw: 'service@scentea.co'
  )
end
