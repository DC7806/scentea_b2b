# frozen_string_literal: true

# == Schema Information
#
# Table name: faqs
#
#  id          :bigint           not null, primary key
#  description :text             default(""), not null
#  position    :integer          default(0), not null
#  region      :integer          default("domestic"), not null
#  title       :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_faqs_on_category_id               (category_id)
#  index_faqs_on_category_id_and_position  (category_id,position)
#  index_faqs_on_category_id_and_title     (category_id,title) UNIQUE WHERE ((title)::text <> ''::text)
#  index_faqs_on_region                    (region)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

require 'rails_helper'

RSpec.describe Faq, type: :model do
  describe 'associations' do
    it { should belong_to(:category).class_name('FaqCategory') }
  end

  describe 'validations' do
    subject { create(:faq) }

    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:description_en) }
    it { should validate_presence_of(:description_zh_tw) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:title_en) }
    it { should validate_presence_of(:title_zh_tw) }
    it { should validate_uniqueness_of(:title).scoped_to(:category_id).case_insensitive }
  end
end
