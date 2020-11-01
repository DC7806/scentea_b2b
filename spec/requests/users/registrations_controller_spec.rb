# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  before do
    Rails.application.env_config['HTTP_ACCEPT_LANGUAGE'] = 'zh-TW'
    create(:site_setting)
  end

  describe 'POST registrations#create' do
    before do
      user_attrs =
        build(:user).attributes
                    .merge(password: Faker::Internet.password(min_length: 6))

      post user_registration_path, params: { user: user_attrs }
    end

    include_examples 'has 302 status code'
  end
end
