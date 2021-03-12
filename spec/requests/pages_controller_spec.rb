# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PagesController', type: :request do
  include_context 'sign in user'

  describe '#about' do
    before { get about_path }

    include_examples 'has 200 status code'
  end

  describe '#affiliation' do
    before { get affiliation_path }

    include_examples 'has 200 status code'
  end

  describe '#homepage' do
    before { get root_path }

    include_examples 'has 200 status code'
  end

  describe '#faq' do
    before { get faq_path }

    include_examples 'has 200 status code'
  end
end
