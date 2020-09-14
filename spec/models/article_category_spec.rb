# frozen_string_literal: true

# rubocop:disable Layout/LineLength
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
#  index_categories_on_position                  (position)
#  index_categories_on_region                    (region)
#  index_categories_on_type_and_region_and_name  (type,region,name) UNIQUE WHERE ((name)::text <> ''::text)
#
# rubocop:enable Layout/LineLength

require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  describe 'associations' do
    it { should have_many(:articles).dependent(:restrict_with_exception) }
  end

  describe 'validations' do
    subject { create(:article_category) }

    it do
      should validate_uniqueness_of(:name).scoped_to(%i[type region])
                                          .case_insensitive
    end
  end
end
