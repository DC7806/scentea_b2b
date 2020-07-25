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

class Account < ApplicationRecord
  enum region: { domestic: 0, foreign: 1 }
  enum status: { created: 0, pending: 1, active: 2 }

  has_one :user, dependent: :restrict_with_exception

  validates :contact_email, presence: true
  validates :company_name,  presence: true, on: :update
  validates :region,        presence: true
  validates :status,        presence: true
  validates :contact_email, format: { with: Devise.email_regexp }
  validates :company_name,  uniqueness: {
    allow_blank: true,
    case_sensitive: false
  }
  validates :tax_id_number, uniqueness: {
    allow_blank: true,
    case_sensitive: false
  }
end
