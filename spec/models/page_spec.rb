# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'validations' do
    subject { create(:page) }

    it { should validate_presence_of(:name_en) }
    it { should validate_presence_of(:name_zh_tw) }
    it { should validate_uniqueness_of(:slug).case_insensitive }
  end
end
