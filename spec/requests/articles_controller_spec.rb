# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  include_context 'sign in user'

  describe '#index' do
    before { get articles_path }

    include_examples 'has 200 status code'
  end

  describe '#show' do
    before { get article_path(slug: create(:article).slug) }

    include_examples 'has 200 status code'
  end
end
