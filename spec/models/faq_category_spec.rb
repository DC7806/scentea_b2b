# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  position   :integer          default(0), not null
#  region     :integer          default("domestic"), not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_position  (position)
#  index_categories_on_region    (region)
#

require 'rails_helper'

RSpec.describe FaqCategory, type: :model do
  describe 'associations' do
    it { should have_many(:faqs).dependent(:restrict_with_exception) }
  end
end
