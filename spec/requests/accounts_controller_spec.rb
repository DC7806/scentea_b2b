# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AccountsController', type: :request do
  include_examples 'sign in user'

  describe 'GET accounts#edit' do
    before { get edit_account_path }

    include_examples 'has 200 status code'
  end
end
