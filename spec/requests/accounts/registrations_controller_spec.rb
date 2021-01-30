# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts::RegistrationsController', type: :request do
  before do
    Rails.application.env_config['HTTP_ACCEPT_LANGUAGE'] = 'zh-TW'
    create(:site_setting)
    sign_in(create(:user, :with_created_account))
  end

  describe 'GET registrations#new' do
    before { get new_account_registration_path }

    include_examples 'has 200 status code'
  end

  describe 'POST registrations#create' do
    before do
      account_attrs = build(:account).attributes

      post account_registration_path, params: { account: account_attrs }
    end

    include_examples 'has 302 status code'
  end
end
