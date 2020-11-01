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

pages_data = [
  { name_en: 'homepage', name_zh: '首頁', slug: '' },
  { name_en: 'about', name_zh: '關於我們', slug: 'about' },
  { name_en: 'affiliation', name_zh: '商業合作', slug: 'affiliation' }
]

pages_data.each do |data|
  page_data = OpenStruct.new(data)

  Page.find_or_create_by(slug: page_data.slug) do |page|
    page.name_en = page_data.name_en
    page.name_zh_tw = page_data.name_zh
  end
end
