# frozen_string_literal: true

# == Schema Information
#
# Table name: page_sections
#
#  id         :bigint           not null, primary key
#  position   :integer          default(0), not null
#  region     :integer          default("domestic"), not null
#  style      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :bigint           not null
#
# Indexes
#
#  index_page_sections_on_page_id   (page_id)
#  index_page_sections_on_position  (position)
#  index_page_sections_on_region    (region)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id) ON DELETE => cascade
#

require 'rails_helper'

RSpec.describe PageSection, type: :model do
  describe 'associations' do
    it { should have_many(:contents).class_name('SectionContent') }
    it { should belong_to(:page) }
  end

  describe 'validations' do
    it { should validate_presence_of(:page) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:style) }
  end
end
