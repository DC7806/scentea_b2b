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

require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:site_name_en) }
    it { should validate_presence_of(:site_name_zh_tw) }
    it { should allow_value('http://foo.bar', '').for(:customization_form_url_en) }
    it { should allow_value('http://foo.bar', '').for(:customization_form_url_zh_tw) }
    it { should allow_value('foo@bar.com').for(:service_email_en) }
    it { should allow_value('foo@bar.com').for(:service_email_zh_tw) }

    it 'should have one valid record only' do
      create(:site_setting)
      subject { build(:site_setting) }

      expect(subject).not_to be_valid
      expect(subject.errors[:base].first).to(
        eq I18n.t('activerecord.errors.messages.one_record_allowed')
      )
    end
  end
end
