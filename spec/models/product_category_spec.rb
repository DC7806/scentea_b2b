# frozen_string_literal: true

# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string           default(""), not null
#  position   :integer          default(1), not null
#  region     :integer          not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_categories_on_ancestry                      (ancestry)
#  index_product_categories_on_position                      (position)
#  index_product_categories_on_region                        (region)
#  index_product_categories_on_region_and_ancestry_and_slug  (region,ancestry,slug) UNIQUE
#

require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  describe 'validations' do
    context 'with presence' do
      subject { build(:product_category, :domestic) }

      it { should validate_presence_of(:name_en) }
      it { should validate_presence_of(:name_zh_tw) }
      it { should validate_presence_of(:position) }
    end

    context 'with uniqueness' do
      describe '#name' do
        context '.valid' do
          subject { build(:product_category, :domestic) }

          it { is_expected.to be_valid }
        end

        context '.invalid' do
          let!(:existing_category) { create(:product_category) }

          subject do
            category = build(:product_category, region: existing_category.region)
            category.name_en = existing_category.name_en
            category.name_zh_tw = existing_category.name_zh_tw
            category
          end

          it { is_expected.to be_invalid }

          it 'has uniqueness error messages' do
            subject.valid?
            error_message = I18n.t('activerecord.errors.messages.taken')

            %i[name_en name_zh_tw].each do |field|
              expect(subject.errors.messages[field].first).to eq error_message
            end
          end
        end
      end
    end
  end

  describe '#add_slug' do
    subject { create(:product_category, :domestic) }

    it 'converts #name_en to slug' do
      expect(subject.slug).to eq subject.name_en.downcase.parameterize
    end
  end
end
