# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id             :bigint           not null, primary key
#  address        :string
#  brand_name     :string
#  company_name   :string           default(""), not null
#  contact_email  :string           not null
#  contact_number :string
#  region         :integer          default("domestic"), not null
#  status         :integer          default("created"), not null
#  tax_id_number  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_accounts_on_region  (region)
#  index_accounts_on_status  (status)
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { create(:account) }

    it { should validate_presence_of(:contact_email) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:status) }
    it { should validate_uniqueness_of(:company_name).case_insensitive }
    it { should validate_uniqueness_of(:tax_id_number).case_insensitive }
  end
end
