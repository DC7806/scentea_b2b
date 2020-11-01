# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PagesController', type: :request do
  include_examples 'sign in user'

  describe 'GET pages#about' do
    before { get about_path }

    include_examples 'has 200 status code'
  end

  describe 'GET pages#affiliation' do
    before { get affiliation_path }

    include_examples 'has 200 status code'
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
