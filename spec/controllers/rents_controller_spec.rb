# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RentsController do
  include_context 'Authenticated User'

  describe 'GET #create' do
    context 'When creating a rent for an user' do
      let(:book) { create(:book) }
      let(:rent) { attributes_for(:rent, book_id: book.id) }
      before do
        post :create, params: { user_id: user.id, rent: rent }
      end

      it 'returns http status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'When given a non existent user ID' do
      let(:book) { create(:book) }
      let(:rent) { attributes_for(:rent, book_id: book.id) }
      before do
        post :create, params: { user_id: User.last.id + 1, rent: rent }
      end

      it 'returns http status 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'responds with an error message' do
        expect(response_body).to have_key('error')
      end
    end

    context 'When there is a missing param' do
      context 'When the book_id is missing' do
        let(:rent) { attributes_for(:rent) }
        before do
          post :create, params: { user_id: user.id, rent: rent }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'When the loan is missing' do
        let(:book) { create(:book) }
        let(:rent) { attributes_for(:rent, loan: nil) }
        before do
          post :create, params: { user_id: user.id, book_id: book.id, rent: rent }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'When the restitution is missing' do
        let(:book) { create(:book) }
        let(:rent) { attributes_for(:rent, restitution: nil) }
        before do
          post :create, params: { user_id: user.id, book_id: book.id, rent: rent }
        end

        it 'returns http status 400' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'When unauthorized user' do
      let(:book)      { create(:book) }
      let(:new_user)  { create(:user) }
      let(:rent)      { attributes_for(:rent, book_id: book.id) }
      before do
        post :create, params: { user_id: new_user.id, rent: rent }
      end

      it 'returns http status created' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET #index' do
    context 'When fetching all the rents of a book' do
      let(:book) { create(:book) }
      let!(:rents) do
        today = Time.zone.today
        (1..5).map do |num|
          create(:rent, book_id: book.id, loan: today + num.day, restitution: today + num.day,
                        user: user)
        end
      end
      before do
        get :index, params: { book_id: book.id }
      end

      it 'responds with the lists of rents' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: RentSerializer
        ).to_json
        expect(response_body['page'].to_json).to eq expected
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with all the rents' do
        expect(response_body['page'].length).to eq rents.count
      end
    end

    context 'When fetching all the rents of an user' do
      let!(:rents) do
        today = Time.zone.today
        (1..5).map do |num|
          create(:rent, user: user, loan: today + num.day, restitution: today + num.day)
        end
      end
      before do
        get :index, params: { user_id: user.id }
      end

      it 'responds with the lists of rents' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: RentSerializer
        ).to_json
        expect(response_body['page'].to_json).to eq expected
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with all the rents' do
        expected = rents.count
        expect(response_body['page'].length).to eq expected
      end
    end

    context 'When given a limit of records expected' do
      let(:book) { create(:book) }
      let!(:rents) do
        today = Time.zone.today
        (1..5).map do |num|
          create(:rent, book: book, loan: today + num.day, restitution: today + num.day,
                        user: user)
        end
      end

      it 'responds with limit of records' do
        get :index, params: { book_id: book.id, limit: 3 }
        expect(response_body['page'].length).to eq 3
      end

      it 'responds with number of next page' do
        get :index, params: { book_id: book.id, limit: 3 }
        expect(response_body['next_page']).to_not eq nil
      end

      it 'responds with next_page null' do
        get :index, params: { book_id: book.id, limit: 5 }
        expect(response_body['next_page']).to eq nil
      end
    end

    context 'When given a non-existent book ID' do
      let!(:rents) do
        today = Time.zone.today
        (1..5).map do |num|
          create(:rent, loan: today + num.day, restitution: today + num.day)
        end
      end
      before do
        get :index, params: { book_id: 1 }
      end

      it 'responds with an error message' do
        expect(response_body).to have_key('error')
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'When given a non-existent user ID' do
      let!(:rents) do
        today = Time.zone.today
        (1..5).map do |num|
          create(:rent, loan: today + num.day, restitution: today + num.day)
        end
      end
      before do
        get :index, params: { user_id: 1 }
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
