# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  before do
    create(:site_setting)
    sign_in(create(:user))
  end

  describe 'GET articles#index' do
    before { get articles_path }

    include_examples 'has 200 status code'
  end

  describe 'GET articles#show' do
    before { get article_path(slug: create(:article).slug) }

    include_examples 'has 200 status code'
  end
end
