# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the users' do
      let!(:low) { create_list(:user, 4) }
      before do
        get :index
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When given a correct ID' do
      let!(:user) { create(:user) }
      before do
        get :show, params: { id: user.id }
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with expected attributes for user' do
        expect(response_body.symbolize_keys).to have_attributes(
          user.attributes.slice(
            :first_name, :last_name, :email, :nickname, :image
          )
        )
      end
    end

    context 'When given a non-existent ID' do
      before do
        get :show, params: { id: 1 }
      end

      it 'responds with an error message' do
        expect(response_body).to have_key('error')
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
