# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :request do
  before do
    create(:site_setting)
    sign_in(create(:user))
  end

  describe 'GET pages#homepage' do
    before { get root_path }

    include_examples 'has 200 status code'
  end

  describe 'GET pages#faq' do
    before { get faq_path }

    include_examples 'has 200 status code'
  end
end
