# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :request do
  before do
    Rails.application.env_config['HTTP_ACCEPT_LANGUAGE'] = 'zh-TW'
    create(:site_setting)
  end

  describe 'GET sessions#new' do
    before { get new_user_session_path }
    include_examples 'has 200 status code'
  end
end
