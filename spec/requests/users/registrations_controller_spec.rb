# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  describe '#create' do
    before do
      user_attrs =
        build(:user).attributes
                    .merge(password: Faker::Internet.password(min_length: 6))

      post user_registration_path, params: { user: user_attrs }
    end

    include_examples 'has 302 status code'
  end
end
