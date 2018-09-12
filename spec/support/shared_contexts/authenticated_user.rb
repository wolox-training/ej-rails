require 'rails_helper'

RSpec.shared_context 'Authenticated User' do
  let(:user) { FactoryBot.create(:user) }
 
  before do
    request.headers.merge! user.create_new_auth_token
  end
 end
