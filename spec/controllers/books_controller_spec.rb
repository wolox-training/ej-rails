require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the books' do
      let!(:books) { create_list(:book, 4) }
      before do
        get :index
      end
 
      it 'responds with the lists of books' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, serializer: BookIndexSerializer
        ).to_json
        expect(response_body['page'].to_json).to eq expected
      end
 
      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with all the books' do
        expected = books.count
        expect(response_body['page'].length).to eq expected
      end
    end

    context 'When given a limit of records expected' do
      let!(:books) { create_list(:book, 5) }

      it 'responds with limit of records' do
        get :index, params: { limit: 3 }
        expect(response_body['page'].length).to eq (3)
      end

      it 'responds with number of next page' do
        get :index, params: { limit: 3 }
        expect(response_body['next_page']).to_not eq (nil) 
      end

      it 'responds with next_page null' do
        get :index, params: { limit: 5 }
        expect(response_body['next_page']).to eq (nil) 
      end
    end
  end

  describe 'GET #show' do
    context 'When given a correct ID' do
      let!(:book) { create(:book) }
      before do
        get :show, params: { id: book.id }
      end

      it 'responds with a book json' do
        expect(response_body.to_json).to eq BookShowSerializer.new(
          book
        ).to_json
      end
 
      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with expected attributes for book' do
        expect(response_body.symbolize_keys).to have_attributes(book.attributes.slice(
          :author,
          :genre,
          :title,
          :year,
          :publisher,
          :image
        ))
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
