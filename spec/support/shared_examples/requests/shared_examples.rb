# frozen_string_literal: true

RSpec.shared_examples 'has 200 status code' do
  it { expect(response).to have_http_status(200) }
end

RSpec.shared_examples 'has 302 status code' do
  it { expect(response).to have_http_status(302) }
end
