# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookSuggestionsController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #create' do
    context 'When logged user' do
      let(:book_suggestion) { attributes_for(:book_suggestion, user_id: user.id) }
      before do
        post :create, params: { book_suggestion: book_suggestion }
      end

      it 'returns http status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'When guest user' do
      let(:book_suggestion) { attributes_for(:book_suggestion, user_id: nil) }
      before do
        post :create, params: { book_suggestion: book_suggestion }
      end

      it 'returns http status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'When there is a missing param' do
      context 'When the title is missing' do
        let(:book_suggestion) { attributes_for(:book_suggestion, title: nil) }
        before do
          post :create, params: { book_suggestion: book_suggestion }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'When the author is missing' do
        let(:book_suggestion) { attributes_for(:book_suggestion, author: nil) }
        before do
          post :create, params: { book_suggestion: book_suggestion }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'When the link is missing' do
        let(:book_suggestion) { attributes_for(:rent, link: nil) }
        before do
          post :create, params: { book_suggestion: book_suggestion }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end
