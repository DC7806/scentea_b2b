# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  describe '#new' do
    before { get new_user_session_path }
    include_examples 'has 200 status code'
  end
end
