# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::RegistrationsController, type: :request do
  before do
    create(:site_setting)
    sign_in(create(:user, :with_created_account))
  end

  describe 'GET registrations#new' do
    before { get new_account_registration_path }

    include_examples 'has 200 status code'
  end
end
