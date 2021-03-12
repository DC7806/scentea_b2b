# frozen_string_literal: true

RSpec.shared_context 'sign in user' do
  before { sign_in(create(:user)) }
end
